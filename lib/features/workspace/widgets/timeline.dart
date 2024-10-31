import 'dart:ffi' as ffi;
import 'dart:math';

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniq_ui/common/test/children_controlled_layout.dart';

import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';
import 'package:uniq_ui/features/workspace/widgets/draggable.dart';
import 'package:uniq_ui/features/workspace/widgets/project.dart';
import 'package:uniq_ui/features/workspace/widgets/timeline_cue.dart';
import 'package:uniq_ui/features/workspace/widgets/timeline_group.dart';

import '../bloc/state.dart';
import '../default_value.dart';

part 'timeline.freezed.dart';

@freezed
class TimelineState with _$TimelineState {
  const TimelineState._();

  factory TimelineState({
    required Id idInfo,
    required Offset offset,
    @Default("타임라인 이름") String name,
    @Default([]) List<TimelineGroupCubit> timelineGroupList,
  }) = _TimelineState;
}

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'void uniq::project::timeline::name_set(const string &)',
      callback: (ApiCallbackMessage callback) {
        var name =
            callback.dataPtr.cast<ffi.Pointer<ffi.Utf8>>().value.toDartString();
        emit(state.copyWith(name: name));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'bool uniq::project::timeline::group_add(const std::shared_ptr<timeline_group> &)',
      callback: (ApiCallbackMessage callback) {
        var groupId = callback.dataPtr.cast<ffi.Int32>().value;
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.addParentId(parentId: id, id: groupId);
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'void uniq::timeline::timeline::group_remove(const id_t)',
      callback: (ApiCallbackMessage callback) {
        var groupId = callback.dataPtr.cast<ffi.Int32>().value;
        emit(state.copyWith(
            timelineGroupList: state.timelineGroupList
                .where((element) => element.state.idInfo.id != groupId)
                .toList()));
      },
    );
  }

  @override
  Future<void> close() {
    CallbackManager.unregisterCallbackByObjIdAll(state.idInfo.id);
    return super.close();
  }

  Duration mouseToDuration(BuildContext context, Offset mouse) {
    var wvbs = context.read<WorkspaceViewBloc>().state;
    var projectCubit = context.read<ProjectCubit>();
    var offset = wvbs.mouseToOffset(mouse) - projectCubit.state.offset;
    return Duration(microseconds: (offset.dx * defaultTimeLength).toInt());
  }

  String getName() => Timeline.nameGet(state.idInfo.id);
  void setName(String name) => Timeline.nameSet(state.idInfo.id, name);
  bool addGroup(int groupId) => Timeline.groupAdd(state.idInfo.id, groupId);
  bool removeGroup(int groupId) =>
      Timeline.groupRemove(state.idInfo.id, groupId);

  void setOffset(Offset offset) {
    emit(state.copyWith(offset: offset));
  }
}

class TimelineWidget extends StatelessWidget {
  final TimelineCubit cubit;
  const TimelineWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimelineCubit>(
      create: (context) => cubit,
      child: BlocBuilder<TimelineCubit, TimelineState>(
        builder: (context, state) {
          var wvb = context.watch<WorkspaceViewBloc>();
          var wvbs = context.watch<WorkspaceViewBloc>().state;
          double currentX = wvbs.offset.dx;
          double currentY = wvbs.offset.dy;
          double currentScale = wvbs.scale;
          double currentTimeLength = wvbs.timeLength;
          double currentTimeScale = defaultTimeLength / currentTimeLength;
          Matrix4 matrixOnlyScale = Matrix4.identity()..scale(currentScale);

          var timelineGroupList =
              context.select((WorkspaceWidgetManagerCubit w) {
            return w.getParentWidgetCubitList<TimelineGroupCubit>(
                parentId: state.idInfo.id);
          });

          // left: state.offset.dx * currentScale + currentX,
          // top: state.offset.dy * currentScale + currentY,
          return DragTarget<WorkspaceDragCubit<TimelineGroupCubit>>(
            onAcceptWithDetails: (onAcceptWithDetails) {
              var timelineGroupCubit = onAcceptWithDetails.data.state.cubit;
              var duration =
                  cubit.mouseToDuration(context, onAcceptWithDetails.offset);
              timelineGroupCubit.startCueCubit.setPoint(duration);
              var wwmc = WorkspaceWidgetManagerCubit.getInstance(
                  timelineGroupCubit.state.idInfo.workspaceId)!;
              var id = timelineGroupCubit.state.idInfo.id;
              var sourceParentId = wwmc.getParentIds(id)[0];
              if (sourceParentId == state.idInfo.id) {
                return;
              }
              cubit.addGroup(
                  onAcceptWithDetails.data.state.cubit.state.idInfo.id);
              if (sourceParentId != 0) {
                var sourceParent =
                    wwmc.getWidgetCubit<TimelineCubit>(sourceParentId);
                sourceParent.removeGroup(id);
              }
            },
            onWillAcceptWithDetails: (onWillAcceptWithDetails) {
              return true;
            },
            onLeave: (data) {},
            builder: (context, candidateData, rejectedData) {
              return ChildrenControlledLayout(
                delegate: TimelineLayoutDelegate(
                  workspaceViewBloc: wvb,
                  timelineCubit: cubit,
                  timelineGroupList: timelineGroupList
                      .map((e) => e.cubit as TimelineGroupCubit)
                      .toList(),
                ),
                children: [
                  LayoutId(
                    id: 0,
                    child: Transform(
                      transform: matrixOnlyScale,
                      child: Row(
                        spacing: 10,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(Icons.power_settings_new),
                            onPressed: () {},
                          ),
                          Text(state.name,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                    ),
                  ),
                  // LayoutId(
                  //   id: 1,
                  //   child: Transform(
                  //     transform: matrixOnlyScale,
                  //     child: Stack(
                  //       children: [
                  //         Positioned(
                  //           left: 0,
                  //           top: 0,
                  //           child: Container(
                  //             width: 100,
                  //             height: 10,
                  //             color: Colors.red,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  for (var pair in timelineGroupList)
                    LayoutId(
                      id: pair.cubit,
                      child: pair.widget!,
                    ),
                  // Text(state.timeLineGroup.toString()),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TimelineLayoutDelegate extends CustomMultiChildLayoutDelegate {
  final WorkspaceViewBloc workspaceViewBloc;
  final TimelineCubit timelineCubit;
  final List<TimelineGroupCubit> timelineGroupList;

  double lastScale = 1.0;
  double lastTimeLength = defaultTimeLength;

  TimelineLayoutDelegate(
      {required this.workspaceViewBloc,
      required this.timelineCubit,
      required this.timelineGroupList});
  @override
  Size performLayout(Size size) {
    Offset offset = Offset.zero;

    var wvbs = workspaceViewBloc.state;
    double currentX = wvbs.offset.dx;
    double currentY = wvbs.offset.dy;
    double currentScale = wvbs.scale;
    double currentTimeLength = wvbs.timeLength;
    double currentTimeScale = defaultTimeLength / currentTimeLength;
    lastScale = currentScale;
    lastTimeLength = currentTimeLength;
    var wwmc = WorkspaceWidgetManagerCubit.getInstance(
        timelineCubit.state.idInfo.workspaceId);

    Size layoutSize = layoutChild(0, BoxConstraints.tightFor());
    positionChild(0, offset);
    offset += Offset(0, layoutSize.height * currentScale);
    // layoutSize = layoutChild(
    //     1, BoxConstraints.loose(Size(double.maxFinite, timelineAllHeight)));
    // positionChild(1, offset);
    // offset += Offset(0, layoutSize.height);
    for (var timelineGroup in timelineGroupList) {
      layoutSize = layoutChild(timelineGroup,
          BoxConstraints.loose(Size(double.maxFinite, timelineAllHeight)));
      WorkspaceWidgetManagerPair timelineCue;
      try {
        // timelineCue = (wwmc!.state.objects[TimelineCueCubit] ?? []).firstWhere(
        //     (pair) => pair.parentId == timelineGroup.state.idInfo.id);
        timelineCue = wwmc!.getParentWidgetCubitList<TimelineCueCubit>(
            parentId: timelineGroup.state.idInfo.id)[0];
      } catch (e) {
        print("TimelineCueCubit not found"); //TODO: 문제 해결
        continue;
      }
      var point =
          (timelineCue.cubit.state as TimelineCueState).point.toDouble();
      timelineGroup.setOffset(timelineCubit.state.offset +
          Offset(point / defaultTimeLength, offset.dy));
      point *= currentScale / currentTimeLength;
      // timelineGroup
      //     .setOffset(Offset(currentX * currentScale + point, offset.dy));
      positionChild(timelineGroup, Offset(point, offset.dy));
      // print();
    }
    offset += Offset(0, timelineAllHeight);
    return Size(size.width == double.infinity ? double.maxFinite : size.width,
        offset.dy);
  }

  @override
  bool shouldRelayout(covariant CustomMultiChildLayoutDelegate oldDelegate) {
    //TODO: implement shouldRelayout
    // print('${this.hashCode} performLayout');
    // var wvbs = workspaceViewBloc.state;
    // print('lastScale: $lastScale, wvbs.scale: ${wvbs.scale}');
    // print(
    //     'lastTimeLength: $lastTimeLength, wvbs.timeLength: ${wvbs.timeLength}');
    // bool flag = lastScale != wvbs.scale || lastTimeLength != wvbs.timeLength;
    // print('shouldRelayout: $flag');
    return true;
  }
}
