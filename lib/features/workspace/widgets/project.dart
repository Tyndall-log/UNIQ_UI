import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:uniq_ui/common/sample_toast.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';

import '../bloc/state.dart';
import '../default_value.dart';

part 'project.freezed.dart';

@freezed
class ProjectState with _$ProjectState {
  const ProjectState._();

  factory ProjectState({
    required Id idInfo,
    required Offset offset,
    @Default("새 프로젝트") String title,
    @Default("제작자 이름") String producerName,
    @Default([]) List<int> timeLine,
  }) = _ProjectState;
}

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'void uniq::project::project::title_set(const string &)',
      callback: (ApiCallbackMessage callback) {
        var title = callback.dataPtr.cast<Pointer<Utf8>>().value.toDartString();
        emit(state.copyWith(title: title));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'void uniq::project::project::producer_name_set(const string &)',
      callback: (ApiCallbackMessage callback) {
        var producerName =
            callback.dataPtr.cast<Pointer<Utf8>>().value.toDartString();
        emit(state.copyWith(producerName: producerName));
      },
    );
    // //timeline_create
    // CallbackManager.registerCallback(
    //   workspaceId: workspaceId,
    //   objId: id,
    //   funcIdName: 'void uniq::project::project::timeline_create()',
    //   callback: (ApiCallbackMessage callback) {
    //     var groupId = callback.dataPtr.cast<Int32>().value;
    //     emit(state.copyWith(timeLine: [...state.timeLine, groupId]));
    //   },
    // );
    // CallbackManager.registerCallback(
    //   workspaceId: workspaceId,
    //   objId: id,
    //   funcIdName: 'void uniq::project::project::timeline_add(const id_t)',
    //   callback: (ApiCallbackMessage callback) {
    //     var groupId = callback.dataPtr.cast<Int32>().value;
    //     emit(state.copyWith(timeLine: [...state.timeLine, groupId]));
    //   },
    // );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'std::shared_ptr<timeline> uniq::project::project::timeline_create(const std::string &)',
      callback: (ApiCallbackMessage callback) {
        var timelineId = callback.dataPtr.cast<Int32>().value;
        emit(state.copyWith(timeLine: [...state.timeLine, timelineId]));
      },
    );
  }

  void setOffset(Offset offset) => emit(state.copyWith(offset: offset));
  void setTitle(String title) => Project.titleSet(state.idInfo.id, title);

  @override
  Future<void> close() {
    CallbackManager.unregisterCallbackByObjIdAll(state.idInfo.id);
    return super.close();
  }
}

@freezed
class ProjectDragState with _$ProjectDragState {
  const ProjectDragState._();
  factory ProjectDragState({
    required ProjectCubit projectCubit,
    required Offset offset,
  }) = _ProjectDragState;
}

class ProjectDragCubit extends Cubit<ProjectDragState> {
  ProjectDragCubit(super.initialState);

  void setOffset(Offset offset) => emit(state.copyWith(offset: offset));
}

class MoveDrag extends Drag {
  final ProjectCubit projectCubit;
  final WorkspaceViewBloc workspaceViewBloc;
  Offset mouseGlobalPosition;
  Offset initialOffset;

  MoveDrag(
      {required this.projectCubit,
      required this.workspaceViewBloc,
      required this.mouseGlobalPosition,
      required this.initialOffset});

  @override
  void cancel() {
    // print('cancel');
  }

  @override
  void end(DragEndDetails details) {
    // print('end');
  }

  @override
  void update(DragUpdateDetails details) {
    var wvbs = workspaceViewBloc.state;
    double currentTimeLength = wvbs.timeLength;
    double currentTimeScale = defaultTimeLength / currentTimeLength;
    double currentScale = wvbs.scale;
    Offset mouseGlobalPositionDelta =
        details.globalPosition - mouseGlobalPosition;

    projectCubit.setOffset(
      Offset(
        initialOffset.dx +
            mouseGlobalPositionDelta.dx / currentScale / currentTimeScale,
        initialOffset.dy + mouseGlobalPositionDelta.dy / currentScale,
      ),
    );
  }
}

class ProjectWidget extends StatefulWidget {
  final ProjectCubit projectCubit;

  const ProjectWidget({required this.projectCubit, super.key});

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  final Offset anchor = const Offset(40, 40);
  late ProjectDragCubit projectDragCubit;

  @override
  void initState() {
    projectDragCubit = ProjectDragCubit(ProjectDragState(
      projectCubit: widget.projectCubit,
      offset: Offset.zero,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.projectCubit,
      child: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          var wvbs = context.watch<WorkspaceViewBloc>().state;
          double currentX = wvbs.offset.dx;
          double currentY = wvbs.offset.dy;
          double currentScale = wvbs.scale;
          double currentTimeLength = wvbs.timeLength;
          double currentTimeScale = defaultTimeLength / currentTimeLength;
          Matrix4 matrixOnlyScale = Matrix4.identity()..scale(currentScale);

          // print(currentX + state.offset.dx * currentTimeScale);
          // print((currentX + state.offset.dx * currentTimeScale) * currentScale);
          // DragTarget
          final _ProjectWidget projectWidget =
              _ProjectWidget(projectCubit: widget.projectCubit);

          return Positioned(
            left: currentX + state.offset.dx * currentTimeScale - anchor.dx,
            top: currentY + state.offset.dy - anchor.dy,
            child: Transform(
              origin: anchor -
                  Offset(
                    currentX + state.offset.dx * currentTimeScale,
                    currentY + state.offset.dy,
                  ),
              transform: matrixOnlyScale,
              child: Column(
                children: [
                  // RawGestureDetector(
                  //   gestures: <Type, GestureRecognizerFactory>{
                  //     DelayedMultiDragGestureRecognizer:
                  //         GestureRecognizerFactoryWithHandlers<
                  //             DelayedMultiDragGestureRecognizer>(
                  //       () => DelayedMultiDragGestureRecognizer(
                  //         delay: Duration(milliseconds: 100),
                  //       ),
                  //       (DelayedMultiDragGestureRecognizer instance) {
                  //         instance.onStart = (Offset offset) {
                  //           return MoveDrag(
                  //             projectCubit: projectCubit,
                  //             workspaceViewBloc:
                  //                 context.read<WorkspaceViewBloc>(),
                  //             mouseGlobalPosition: offset,
                  //             initialOffset: state.offset,
                  //           );
                  //         };
                  //       },
                  //     ),
                  //   },
                  //   child: _ProjectWidget(projectCubit: projectCubit),
                  // ),
                  LongPressDraggable<ProjectDragCubit>(
                    data: ProjectDragCubit(ProjectDragState(
                      projectCubit: widget.projectCubit,
                      offset: state.offset,
                    )),
                    feedback: Opacity(
                      opacity: 1,
                      child: Transform(
                        // origin: -Offset(
                        //   currentX + state.offset.dx * currentTimeScale - 40,
                        //   currentY + state.offset.dy - 40,
                        // ),
                        transform: matrixOnlyScale,
                        child: Material(
                          color: Colors.transparent,
                          child: projectWidget,
                        ),
                      ),
                    ),
                    dragAnchorStrategy: (draggable, context, position) {
                      Offset offset =
                          childDragAnchorStrategy(draggable, context, position);
                      projectDragCubit.setOffset(offset);
                      return offset * currentScale;
                    },
                    delay: const Duration(milliseconds: 200),
                    childWhenDragging: Opacity(
                      opacity: 0.2,
                      child: projectWidget,
                    ),
                    onDragUpdate: (details) {
                      // print(details.globalPosition);
                    },
                    child: projectWidget,
                  ),
                  // for (var id in state.timeLine)
                  //   Container(
                  //     width: 10,
                  //     height: 10,
                  //     decoration: BoxDecoration(
                  //       color: Colors.blue,
                  //       shape: BoxShape.circle,
                  //     ),
                  //   ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProjectWidget extends StatelessWidget {
  final ProjectCubit projectCubit;

  const _ProjectWidget({
    required this.projectCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = projectCubit.state;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
          ),
          child: Container(
            // width: 200,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 70,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                        child: Text(
                          state.title,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      // 제목 수정 버튼
                      IconButton(
                        padding: EdgeInsets.all(4),
                        iconSize: 15,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          context.read<ProjectCubit>().setTitle('프로젝트 제목');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {},
                      ),
                      // 설정 버튼
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.settings),
                        onPressed: () {},
                      ),
                      // 저장 버튼
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.save),
                        onPressed: () {},
                      ),
                      // 삭제 버튼
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          final bool r = context
                              .read<WorkspaceProjectManagerCubit>()
                              .removeProject(id: state.idInfo.id);
                          if (r) {
                            SampleToast.show(
                              context: context,
                              title: '프로젝트 삭제 성공',
                              description: '프로젝트를 삭제했습니다.',
                              type: ToastificationType.success,
                            );
                          } else {
                            SampleToast.show(
                              context: context,
                              title: '프로젝트 삭제 실패',
                              description: '프로젝트를 삭제하는 중 오류가 발생했습니다.',
                              type: ToastificationType.error,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                //썸내일 이미지
                Icons.image,
                size: 30,
              ),
            ),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     context.read<ProjectCubit>().setTitle('프로젝트 제목');
        //   },
        //   child: Text('프로젝트 제목 변경'),
        // ),
      ],
    );
  }
}
