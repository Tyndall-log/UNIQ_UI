import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniq_ui/common/test/children_controlled_layout.dart';

import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';
import 'package:uniq_ui/features/workspace/widgets/audio_block.dart';
import 'package:uniq_ui/features/workspace/widgets/draggable.dart';
import 'package:uniq_ui/features/workspace/widgets/timeline_cue.dart';
import 'package:uniq_ui/features/workspace/widgets/event_block.dart';

import '../bloc/state.dart';
import '../default_value.dart';
import 'common_block.dart';

part 'timeline_group.freezed.dart';

@freezed
class TimelineGroupState with _$TimelineGroupState {
  const TimelineGroupState._();

  factory TimelineGroupState({
    required Id idInfo,
    required Offset offset,
    required Size size,
    @Default(100 * 1000) int eventDuration,
    @Default(0) int startCueId,
    @Default([]) List<AudioBlockCubit> audioBlockList,
  }) = _TimelineGroupState;
}

class TimelineGroupCubit extends Cubit<TimelineGroupState> {
  TimelineGroupCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'void uniq::project::timeline_group::start_cue_set(const std::shared_ptr<timeline_cue> &)',
      callback: (ApiCallbackMessage callback) {
        var timelineCueId = callback.dataPtr.cast<ffi.Uint64>().value;
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.addParentId(parentId: id, id: timelineCueId);
        emit(state.copyWith(startCueId: timelineCueId));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'void uniq::project::timeline_group::press_duration_set(press_duration_t)',
      callback: (ApiCallbackMessage callback) {
        var eventDuration = callback.dataPtr.cast<ffi.Int64>().value;
        if (eventDuration < 1000 * 100) {
          eventDuration = 1000 * 100; // 임시로 최소값 설정
        }
        emit(state.copyWith(eventDuration: eventDuration));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'void uniq::project::timeline_group::segment_set(const std::shared_ptr<audio_segment> &)',
      callback: (ApiCallbackMessage callback) {
        var segmentId = callback.dataPtr.cast<ffi.Int32>().value;
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.addParentId(parentId: id, id: segmentId);
      },
    );
    // CallbackManager.registerCallback(
    //   workspaceId: workspaceId,
    //   objId: id,
    //   funcIdName:
    //       'bool uniq::project::timeline::group_add(const std::shared_ptr<timeline_group> &)',
    //   callback: (ApiCallbackMessage callback) {
    //     var groupId = callback.dataPtr.cast<ffi.Int32>().value;
    //     emit(state.copyWith(timeLineGroup: [...state.timeLineGroup, groupId]));
    //   },
    // );
    // CallbackManager.registerCallback(
    //   workspaceId: workspaceId,
    //   objId: id,
    //   funcIdName: 'void uniq::timeline::timeline::group_remove(const id_t)',
    //   callback: (ApiCallbackMessage callback) {
    //     var groupId = callback.dataPtr.cast<ffi.Int32>().value;
    //     emit(state.copyWith(
    //         timeLineGroup:
    //             state.timeLineGroup.where((e) => e != groupId).toList()));
    //   },
    // );
  }

  @override
  Future<void> close() {
    CallbackManager.unregisterCallbackByObjIdAll(state.idInfo.id);
    return super.close();
  }

  String getName() => Timeline.nameGet(state.idInfo.id);
  void setName(String name) => Timeline.nameSet(state.idInfo.id, name);
  void addGroup(int groupId) => Timeline.groupAdd(state.idInfo.id, groupId);
  void removeGroup(int groupId) =>
      Timeline.groupRemove(state.idInfo.id, groupId);

  TimelineCueCubit get startCueCubit {
    var id = state.startCueId;
    return WorkspaceWidgetManagerCubit.getInstance(state.idInfo.workspaceId)!
        .getWidgetCubit<TimelineCueCubit>(id);
  }

  void setOffset(Offset offset) {
    emit(state.copyWith(offset: offset));
  }
}

class TimelineGroupWidget extends StatelessWidget {
  final TimelineGroupCubit cubit;
  const TimelineGroupWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return WorkspaceDraggable<TimelineGroupCubit>(
      cubit: WorkspaceDragCubit<TimelineGroupCubit>(WorkspaceDragState(
        cubit: cubit,
        offset: Offset.zero,
        size: Size.zero,
      )),
      autoScale: false,
      child: _TimelineGroupWidget(cubit: cubit),
    );
  }
}

class _TimelineGroupWidget extends StatelessWidget {
  final TimelineGroupCubit cubit;
  const _TimelineGroupWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<TimelineGroupCubit, TimelineGroupState>(
        builder: (context, state) {
          var wvb = context.watch<WorkspaceViewBloc>();
          var wvbs = context.watch<WorkspaceViewBloc>().state;
          double currentX = wvbs.offset.dx;
          double currentY = wvbs.offset.dy;
          double currentScale = wvbs.scale;
          double currentTimeLength = wvbs.timeLength;
          double currentTimeScale = defaultTimeLength / currentTimeLength;
          Matrix4 matrixOnlyScale = Matrix4.identity()..scale(currentScale);

          var AudioBlockList = context.select((WorkspaceWidgetManagerCubit w) {
            return w.getParentWidgetCubitList<AudioBlockCubit>(
                parentId: state.idInfo.id);
          });
          // print((AudioBlockList[0].cubit.state as AudioBlockState).name);
          // print((AudioBlockList[0].cubit.state as AudioBlockState).idInfo.id);
          // print((AudioBlockList[0].cubit.state as AudioBlockState).audioCueEndId

          // left: state.offset.dx * currentScale + currentX,
          // top: state.offset.dy * currentScale + currentY,
          for (var pair in AudioBlockList) {
            (pair.cubit as AudioBlockCubit).setOffset(Offset(
              state.offset.dx,
              state.offset.dy + timelineSpace + timelineEventHeight,
            ));
            // ..setSize(Size(
            //   state.size.width,
            //   timelineAudioHeight,
            // ));
          }
          return SizedBox(
            width: double.maxFinite,
            child: Transform(
              transform: matrixOnlyScale,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: timelineSpace,
                children: [
                  SizedBox(
                    width: state.eventDuration *
                        currentTimeScale /
                        defaultTimeLength,
                    height: timelineEventHeight,
                    // color: Colors.red,
                    child: const EventBlockWidget(),
                  ),
                  for (var pair in AudioBlockList) pair.widget!,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventBlockWidget extends StatelessWidget {
  const EventBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBlock(
      color: Colors.indigoAccent.shade100,
      child: Text('0, 0'),
    );
  }
}
