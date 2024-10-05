import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';

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
    @Default([]) List<int> timeLineGroup,
  }) = _TimeLineState;
}

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'void uniq::timeline::timeline::name_set(const string &)',
      callback: (ApiCallbackMessage callback) {
        var name = callback.dataPtr.cast<Pointer<Utf8>>().value.toDartString();
        emit(state.copyWith(name: name));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'void uniq::timeline::timeline::group_add(const id_t)',
      callback: (ApiCallbackMessage callback) {
        var groupId = callback.dataPtr.cast<Int32>().value;
        emit(state.copyWith(timeLineGroup: [...state.timeLineGroup, groupId]));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'void uniq::timeline::timeline::group_remove(const id_t)',
      callback: (ApiCallbackMessage callback) {
        var groupId = callback.dataPtr.cast<Int32>().value;
        emit(state.copyWith(
            timeLineGroup:
                state.timeLineGroup.where((e) => e != groupId).toList()));
      },
    );
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

class TimelineWidget extends StatelessWidget {
  final TimelineCubit cubit;
  const TimelineWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimelineCubit>(
      create: (context) => cubit,
      child: BlocBuilder<TimelineCubit, TimelineState>(
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Text(state.name),
                Text(state.timeLineGroup.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
