// bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:math' as math;

import 'event.dart';
import 'state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  double _previousScale = 1.0;
  Offset _previousFocalPoint = Offset.zero;
  Offset _lastFocalPoint = Offset.zero;
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

  WorkspaceBloc(TickerProvider vsync) : super(const TransformationInitial()) {
    _animationController = AnimationController(vsync: vsync)
      ..addListener(() => add(const ScaleAnimationEvent()));
    on<ScaleStartEvent>(_onScaleStart);
    on<ScaleUpdateEvent>(_onScaleUpdate);
    on<ScaleEndEvent>(_onScaleEnd);
    on<ScaleAnimationEvent>(_onScaleAnimation);
    on<TimeScaleStartEvent>(_onTimeLengthStart);
    on<TimeScaleUpdateEvent>(_onTimeLengthUpdate);
    on<TimeScaleEndEvent>(_onTimeLengthEnd);
  }

  void _panAndZoomStart(
      Emitter<WorkspaceState> emit, Offset controlPoint, double viewScale) {
    _previousOffset = _offset;
    _previousScale = _viewScale;
    _previousFocalPoint = controlPoint;
    _previousTimeLength = _timeLength;
    _animationController.stop();
  }

  void _panAndZoomUpdate(
    Emitter<WorkspaceState> emit,
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
    _viewScale = _previousScale * scale;
    if (_viewScale < _timeLength / _maxTimeLength) {
      _viewScale = _timeLength / _maxTimeLength;
      scale = _viewScale / _previousScale;
    } else if (_timeLength / _minTimeLength < _viewScale) {
      _viewScale = _timeLength / _minTimeLength;
      scale = _viewScale / _previousScale;
    }

    _offset = _previousOffset +
        (translationDelta + controlPoint * (1 - scale)) / _viewScale;
    if (timeScale != 1) {
      _offset -= Offset(
          (_offset.dx - controlPoint.dx / _viewScale) * (1 - timeScale), 0);
    }

    emit(TransformationState(_offset, _viewScale, _timeLength));
  }

  void _onScaleAnimation(
      ScaleAnimationEvent event, Emitter<WorkspaceState> emit) {
    _viewScale = _scaleAnimation.value;
    _offset = _offsetAnimation.value;
    _offset += (_offset - _lastFocalPoint) * (_viewScale / _previousScale - 1);
    // var matrix = Matrix4.identity()
    //   ..translate(_offset.dx, _offset.dy)
    //   ..scale(_viewScale);
    // emit(TransformationState(matrix, _offset, _scale));
  }

  void _onScaleStart(ScaleStartEvent event, Emitter<WorkspaceState> emit) {
    final details = event.details;
    _panAndZoomStart(emit, details.focalPoint, _viewScale);
  }

  void _onScaleUpdate(ScaleUpdateEvent event, Emitter<WorkspaceState> emit) {
    final ScaleUpdateDetails details = event.details;
    _panAndZoomUpdate(emit, _previousFocalPoint, _previousFocalPoint,
        details.focalPoint, details.scale, 1);
  }

  void _onScaleEnd(ScaleEndEvent event, Emitter<WorkspaceState> emit) {
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
    _previousScale = _viewScale;
    _previousOffset = _offset;
  }

  void _onTimeLengthStart(
      TimeScaleStartEvent event, Emitter<WorkspaceState> emit) {
    final details = event.details;
    _panAndZoomStart(emit, details.focalPoint, _viewScale);
  }

  void _onTimeLengthUpdate(
      TimeScaleUpdateEvent event, Emitter<WorkspaceState> emit) {
    final ScaleUpdateDetails details = event.details;
    _lastFocalPoint = details.localFocalPoint;
    final Offset translationDelta = details.focalPoint - _previousFocalPoint;

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
      var timeScale = math.exp((details.focalPoint.dx - _dragStart.dx) / 100);
      var currentPoint = Offset(_dragStart.dx, details.focalPoint.dy);
      _panAndZoomUpdate(
          emit, _previousFocalPoint, _dragStart, currentPoint, 1, timeScale);
    } else if (_verticalDrag) {
      if (_verticalDragPinMode) {
        var scale = (details.focalPoint.dy - _previousFocalPoint.dy) /
            (_dragStart.dy - _previousFocalPoint.dy);
        _panAndZoomUpdate(
            emit, _dragStart, _dragStart, details.focalPoint, scale, 1);
      } else {
        var scale = math.exp((details.focalPoint.dy - _dragStart.dy) / 100);
        var currentPoint = Offset(details.focalPoint.dx, _dragStart.dy);
        _panAndZoomUpdate(
            emit, _previousFocalPoint, _dragStart, currentPoint, scale, 1);
      }
    }
    emit(TransformationState(_offset, _viewScale, _timeLength));
  }

  void _onTimeLengthEnd(TimeScaleEndEvent event, Emitter<WorkspaceState> emit) {
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
}
