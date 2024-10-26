import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';

part 'timeline_cue.freezed.dart';

@freezed
class TimelineCueState with _$TimelineCueState {
  const TimelineCueState._();

  factory TimelineCueState({
    required Id idInfo,
    @Default(0) int point,
  }) = _TimelineCueState;
}

class TimelineCueCubit extends Cubit<TimelineCueState> {
  TimelineCueCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'void uniq::project::timeline_cue::cue_point_set(const cue_point_t)',
      callback: (ApiCallbackMessage callback) {
        var point = callback.dataPtr.cast<ffi.Int64>().value;
        emit(state.copyWith(point: point));
      },
    );
  }

  void setPoint(Duration point) =>
      TimelineCue.cuePointSet(state.idInfo.id, point.inMicroseconds);

  @override
  Future<void> close() {
    CallbackManager.unregisterCallbackByObjIdAll(state.idInfo.id);
    return super.close();
  }
}
