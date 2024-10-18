// bloc.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:math' as math;
import 'dart:ffi';

import 'package:uniq_ui/common/uniq_library/uniq.dart';
import '../default_value.dart';
import '../widgets/project.dart';

import 'event.dart';
import 'state.dart';

//========== WorkspaceViewBloc Start ==========
class WorkspaceViewBloc extends Bloc<WorkspaceViewEvent, WorkspaceViewState> {
  final int workspaceId;
  double _previousViewScale = 1.0;
  Offset _previousLocalFocalPoint = Offset.zero;
  Offset _lastLocalFocalPoint = Offset.zero;
  final double coefficient = 0.0000135;

  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  double _viewScale = 1.0;
  double _timeLength = 10 * 1000; // 10ms (ns/pixel)
  double _previousTimeLength = 10 * 1000; // 10ms (ns/pixel)
  double _maxTimeLength = 1000 * 1000; // 1s (ns/pixel)
  double _minTimeLength = 10; // 10ns (ns/pixel)

  double _dragThreshold = 30;
  Offset _dragStart = Offset.zero;
  bool _horizontalDrag = false;
  bool _verticalDrag = false;
  final bool _verticalDragPinMode = false;

  late AnimationController _animationController;
  Animation<Offset> _offsetAnimation =
      const AlwaysStoppedAnimation(Offset.zero);
  Animation<double> _scaleAnimation = const AlwaysStoppedAnimation(1.0);

  WorkspaceViewBloc({
    required this.workspaceId,
    required TickerProvider vsync,
    required WorkspaceViewState initialState,
  }) : super(initialState) {
    print('WorkspaceViewBloc');
    _animationController = AnimationController(vsync: vsync)
      ..addListener(() => add(const ScaleAnimationEvent()));
    on<ScaleStartEvent>(_onScaleStart);
    on<ScaleUpdateEvent>(_onScaleUpdate);
    on<ScaleEndEvent>(_onScaleEnd);
    on<ScaleAnimationEvent>(_onScaleAnimation);
    on<ScaleTickEvent>(_onScaleTick);
    on<MoveTickEvent>(_onMoveTick);
    on<TimeScaleStartEvent>(_onTimeLengthStart);
    on<TimeScaleUpdateEvent>(_onTimeLengthUpdate);
    on<TimeScaleEndEvent>(_onTimeLengthEnd);
  }

  void _panAndZoomStart(
      Emitter<WorkspaceViewState> emit, Offset controlPoint, double viewScale) {
    _previousOffset = _offset;
    _previousViewScale = _viewScale;
    _previousLocalFocalPoint = controlPoint;
    _previousTimeLength = _timeLength;
    _animationController.stop();
  }

  void _panAndZoomUpdate(
    Emitter<WorkspaceViewState> emit,
    Offset controlPoint,
    Offset startPoint,
    Offset currentPoint,
    double viewScale,
    double timeScale,
  ) {
    final Offset translationDelta = currentPoint - startPoint;
    var length = _previousTimeLength / timeScale;
    if (_maxTimeLength < length) {
      length = _maxTimeLength;
      timeScale = _previousTimeLength / _maxTimeLength;
    } else if (length < _minTimeLength) {
      length = _minTimeLength;
      timeScale = _previousTimeLength / _minTimeLength;
    }
    _timeLength = length;

    var scale = viewScale;
    _viewScale = _previousViewScale * scale;
    if (_viewScale < _timeLength / _maxTimeLength) {
      _viewScale = _timeLength / _maxTimeLength;
      scale = _viewScale / _previousViewScale;
    } else if (_timeLength / _minTimeLength < _viewScale) {
      _viewScale = _timeLength / _minTimeLength;
      scale = _viewScale / _previousViewScale;
    }

    _offset = _previousOffset +
        (translationDelta + controlPoint * (1 - scale)) / _viewScale;
    if (timeScale != 1) {
      _offset -= Offset(
          (_offset.dx - controlPoint.dx / _viewScale) * (1 - timeScale), 0);
    }

    emit(WorkspaceViewState(_offset, _viewScale, _timeLength));
  }

  void _onScaleAnimation(
      ScaleAnimationEvent event, Emitter<WorkspaceViewState> emit) {
    _viewScale = _scaleAnimation.value;
    _offset = _offsetAnimation.value;
    _offset += (_offset - _lastLocalFocalPoint) *
        (_viewScale / _previousViewScale - 1);
    // var matrix = Matrix4.identity()
    //   ..translate(_offset.dx, _offset.dy)
    //   ..scale(_viewScale);
    // emit(TransformationState(matrix, _offset, _scale));
  }

  void _onScaleStart(ScaleStartEvent event, Emitter<WorkspaceViewState> emit) {
    final details = event.details;
    _panAndZoomStart(emit, details.localFocalPoint, _viewScale);
  }

  void _onScaleUpdate(
      ScaleUpdateEvent event, Emitter<WorkspaceViewState> emit) {
    final ScaleUpdateDetails details = event.details;
    _panAndZoomUpdate(emit, _previousLocalFocalPoint, _previousLocalFocalPoint,
        details.localFocalPoint, details.scale, 1);
  }

  void _onScaleEnd(ScaleEndEvent event, Emitter<WorkspaceViewState> emit) {
    return;
    final ScaleEndDetails details = event.details;

    final velocity = details.velocity.pixelsPerSecond;
    if (10 < velocity.distance) {
      final frictionX =
          FrictionSimulation(coefficient, _offset.dx, velocity.dx);
      final frictionY =
          FrictionSimulation(coefficient, _offset.dy, velocity.dy);

      _offsetAnimation = Tween<Offset>(
        begin: _offset,
        end: Offset(frictionX.finalX, frictionY.finalX),
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.decelerate,
        ),
      );
      _scaleAnimation = AlwaysStoppedAnimation(_viewScale);
      final double tFinal = _getFinalTime(
        details.velocity.pixelsPerSecond.distance,
        coefficient,
      );
      _animationController.duration =
          Duration(milliseconds: (tFinal * 1000).round());
      _animationController.forward(from: 0);
    }

    final scaleVelocity = details.scaleVelocity;
    if (0.1 < scaleVelocity.abs()) {
      final frictionScale =
          FrictionSimulation(coefficient * 200, _viewScale, scaleVelocity / 10);
      _scaleAnimation = Tween<double>(
        begin: _viewScale,
        end: frictionScale.finalX,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.decelerate,
        ),
      );
      _offsetAnimation = AlwaysStoppedAnimation(_offset);
      final double tFinal = _getFinalTime(scaleVelocity.abs(), coefficient,
          effectivelyMotionless: 0.1);
      _animationController.duration =
          Duration(milliseconds: (tFinal * 1000).round());
      _animationController.forward(from: 0);
    }
    _previousOffset = _offset;
    _previousViewScale = _viewScale;
    _previousOffset = _offset;
  }

  void _onScaleTick(ScaleTickEvent event, Emitter<WorkspaceViewState> emit) {
    _panAndZoomStart(emit, event.focalPoint, _viewScale);
    _panAndZoomUpdate(emit, event.focalPoint, event.focalPoint,
        event.focalPoint, event.scale, 1);
  }

  void _onMoveTick(MoveTickEvent event, Emitter<WorkspaceViewState> emit) {
    _panAndZoomStart(emit, _lastLocalFocalPoint, _viewScale);
    _panAndZoomUpdate(emit, _lastLocalFocalPoint, _lastLocalFocalPoint,
        _lastLocalFocalPoint - event.offset, 1, 1);
  }

  void _onTimeLengthStart(
      TimeScaleStartEvent event, Emitter<WorkspaceViewState> emit) {
    final details = event.details;
    _panAndZoomStart(emit, details.localFocalPoint, _viewScale);
  }

  void _onTimeLengthUpdate(
      TimeScaleUpdateEvent event, Emitter<WorkspaceViewState> emit) {
    final ScaleUpdateDetails details = event.details;
    _lastLocalFocalPoint = details.localFocalPoint;
    final Offset translationDelta =
        details.localFocalPoint - _previousLocalFocalPoint;

    if (!_horizontalDrag && !_verticalDrag) {
      if (translationDelta.distance < _dragThreshold) {
        return;
      }
      _dragStart = details.localFocalPoint;
      if (translationDelta.dx.abs() < translationDelta.dy.abs()) {
        _verticalDrag = true;
      } else {
        _horizontalDrag = true;
      }
    }

    if (_horizontalDrag) {
      var timeScale =
          math.exp((details.localFocalPoint.dx - _dragStart.dx) / 100);
      var currentPoint = Offset(_dragStart.dx, details.localFocalPoint.dy);
      _panAndZoomUpdate(emit, _previousLocalFocalPoint, _dragStart,
          currentPoint, 1, timeScale);
    } else if (_verticalDrag) {
      if (_verticalDragPinMode) {
        var scale = (details.localFocalPoint.dy - _previousLocalFocalPoint.dy) /
            (_dragStart.dy - _previousLocalFocalPoint.dy);
        _panAndZoomUpdate(
            emit, _dragStart, _dragStart, details.localFocalPoint, scale, 1);
      } else {
        var scale =
            math.exp((details.localFocalPoint.dy - _dragStart.dy) / 100);
        var currentPoint = Offset(details.localFocalPoint.dx, _dragStart.dy);
        _panAndZoomUpdate(
            emit, _previousLocalFocalPoint, _dragStart, currentPoint, scale, 1);
      }
    }
    emit(WorkspaceViewState(_offset, _viewScale, _timeLength));
  }

  void _onTimeLengthEnd(
      TimeScaleEndEvent event, Emitter<WorkspaceViewState> emit) {
    _verticalDrag = false;
    _horizontalDrag = false;
    return;
  }

  @override
  Future<void> close() {
    _animationController.dispose();
    return super.close();
  }

  double _getFinalTime(double velocity, double drag,
      {double effectivelyMotionless = 10}) {
    return math.log(effectivelyMotionless / velocity) / math.log(drag / 100);
  }

  Offset mouseToOffset(Offset mouse) {
    return Offset(
      (mouse.dx / state.scale - state.offset.dx) /
          defaultTimeLength *
          state.timeLength,
      mouse.dy / state.scale - state.offset.dy,
    );
  }
}
//========== WorkspaceViewBloc End ==========

// //========== WorkspaceManagerCubit Start ==========
// class WorkspaceManagerCubit extends Cubit<WorkspaceManagerState> {
//   WorkspaceManagerCubit() : super(WorkspaceManagerState()) {
//     CallbackManager.registerCallback(
//       workspaceId: state.workspaceId,
//       preferredId: PreferredId.create,
//       funcIdName: 'uniq::workspace::workspace',
//       callback: (message) {
//         var data = message.dataPtr.cast<IdLifecycle>().ref;
//         var id = data.id;
//         emit(state.copyWith(
//           workspaces: [
//             ...state.workspaces,
//             WorkspaceCubit(WorkspaceState(idInfo: Id(id: id))),
//           ],
//         ));
//       },
//     );
//     CallbackManager.registerCallback(
//       workspaceId: state.workspaceId,
//       preferredId: PreferredId.destroy,
//       funcIdName: 'uniq::workspace::workspace',
//       callback: (message) {
//         var data = message.dataPtr.cast<IdLifecycle>().ref;
//         var id = data.id;
//         final workspaceList = state.workspaces.where((workspace) {
//           if (workspace.state.idInfo.id == id) {
//             workspace.close();
//             return false;
//           }
//           return true;
//         }).toList();
//         emit(state.copyWith(workspaces: workspaceList));
//       },
//     );
//   }
//
//   @override
//   Future<void> close() {
//     for (var workspace in state.workspaces) {
//       workspace.close();
//     }
//     state.workspaces.clear();
//     CallbackManager.unregisterCallbackByWorkspaceIdAll(state.workspaceId);
//     return super.close();
//   }
//
//   int createWorkspace() => Workspace.workspaceCreate();
//
//   bool removeWorkspace({required int id}) => Workspace.workspaceRemove(id);
// }

//========== WorkspaceProjectManagerCubit Start ==========
class WorkspaceProjectManagerCubit extends Cubit<WorkspaceProjectManagerState> {
  List<Offset> projectPosition = [];
  WorkspaceProjectManagerCubit({required int workspaceId})
      : super(WorkspaceProjectManagerState(workspaceId: workspaceId)) {
    CallbackManager.registerCallback(
      workspaceId: state.workspaceId,
      preferredId: PreferredId.create,
      funcIdName: 'uniq::project::project',
      callback: (message) {
        var data = message.dataPtr.cast<IdLifecycle>().ref;
        var id = data.id;
        Offset offset = projectPosition.isEmpty
            ? const Offset(0, 0)
            : projectPosition.removeAt(0);
        emit(state.copyWith(
          projects: [
            ...state.projects,
            ProjectCubit(ProjectState(idInfo: Id(id: id), offset: offset)),
          ],
        ));
        Project.launchpadAutoConnect(data.id); //임시
      },
    );
    CallbackManager.registerCallback(
      workspaceId: state.workspaceId,
      preferredId: PreferredId.destroy,
      funcIdName: 'uniq::project::project',
      callback: (message) {
        var data = message.dataPtr.cast<IdLifecycle>().ref;
        var id = data.id;
        final projectList = state.projects.where((project) {
          if (project.state.idInfo.id == id) {
            project.close();
            return false;
          }
          return true;
        }).toList();
        emit(state.copyWith(projects: projectList));
      },
    );
  }

  @override
  Future<void> close() {
    // print('WorkspaceProjectManagerCubit close() called');
    for (var project in state.projects) {
      project.close();
    }
    state.projects.clear();
    CallbackManager.unregisterCallbackByWorkspaceIdAll(state.workspaceId);
    return super.close();
  }

  int createProject() => Workspace.projectCreate(state.workspaceId);

  bool removeProject({required int id}) =>
      Workspace.projectRemove(state.workspaceId, id);
}
//========== WorkspaceProjectManagerCubit End ==========
