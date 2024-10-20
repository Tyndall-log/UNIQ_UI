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
import 'common_block.dart';

part 'event_block.freezed.dart';

@freezed
class EventBlockState with _$EventBlockState {
  const EventBlockState._();

  factory EventBlockState({
    required Id idInfo,
    required Offset offset,
    // @Default([]) List<int> timeLineGroup,
  }) = _EventBlockState;
}

class EventBlockCubit extends Cubit<EventBlockState> {
  EventBlockCubit(super.initialState) {
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

class EventBlockWidget extends StatelessWidget {
  final EventBlockCubit cubit;
  const EventBlockWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventBlockCubit>(
      create: (context) => cubit,
      child: BlocBuilder<EventBlockCubit, EventBlockState>(
        builder: (context, state) {
          return CommonBlock(
            color: Colors.blue,
            child: Text('0, 0'),
          );
        },
      ),
    );
  }
}
