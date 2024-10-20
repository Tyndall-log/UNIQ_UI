import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniq_ui/common/test/children_controlled_layout.dart';

import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';

import '../bloc/state.dart';
import '../default_value.dart';

part 'timeline_group.freezed.dart';

@freezed
class TimelineGroupState with _$TimelineGroupState {
  const TimelineGroupState._();

  factory TimelineGroupState({
    required Id idInfo,
    required Offset offset,
    // @Default([]) List<int> timeLineGroup,
  }) = _TimelineGroupState;
}

class TimelineGroupCubit extends Cubit<TimelineGroupState> {
  TimelineGroupCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    // CallbackManager.registerCallback(
    //   workspaceId: workspaceId,
    //   objId: id,
    //   funcIdName: 'void uniq::project::timeline::name_set(const string &)',
    //   callback: (ApiCallbackMessage callback) {
    //     var name =
    //         callback.dataPtr.cast<ffi.Pointer<ffi.Utf8>>().value.toDartString();
    //     emit(state.copyWith(name: name));
    //   },
    // );
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
}

class TimelineGroupWidget extends StatelessWidget {
  final TimelineGroupCubit cubit;
  const TimelineGroupWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimelineGroupCubit>(
      create: (context) => cubit,
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

          // left: state.offset.dx * currentScale + currentX,
          // top: state.offset.dy * currentScale + currentY,
          return Container(
            width: 100,
            height: 100,
            color: Colors.red,
          );
        },
      ),
    );
  }
}
