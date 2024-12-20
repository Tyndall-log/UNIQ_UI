import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';

part 'audio_cue.freezed.dart';

@freezed
class AudioCueState with _$AudioCueState {
  const AudioCueState._();

  factory AudioCueState({
    required Id idInfo,
    @Default([]) List<VoidCallback> callbackList,
    @Default(0) int point,
  }) = _TimelineCueState;
}

class AudioCueCubit extends Cubit<AudioCueState> {
  AudioCueCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'uniq::audio_cue::audio_cue(const uint64_t)',
      callback: (ApiCallbackMessage callback) {
        var point = callback.dataPtr.cast<ffi.Int64>().value;
        emit(state.copyWith(point: point));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName: 'void uniq::audio_cue::set(const uint64_t)',
      callback: (ApiCallbackMessage callback) {
        var point = callback.dataPtr.cast<ffi.Int64>().value;
        emit(state.copyWith(point: point));
        for (var callback in state.callbackList) {
          callback();
        }
      },
    );
  }

  void setPoint(int point) => TimelineCue.cuePointSet(state.idInfo.id, point);

  void addCallback(VoidCallback callback) {
    emit(state.copyWith(callbackList: [...state.callbackList, callback]));
  }

  @override
  Future<void> close() {
    CallbackManager.unregisterCallbackByObjIdAll(state.idInfo.id);
    return super.close();
  }
}

class AudioCueWidget extends StatelessWidget {
  final Id idInfo;
  final Offset offset;
  final Size size;
  final Widget? content;

  const AudioCueWidget({
    required this.idInfo,
    required this.offset,
    required this.size,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioCueCubit(
        AudioCueState(
          idInfo: idInfo,
        ),
      ),
      child: BlocBuilder<AudioCueCubit, AudioCueState>(
        builder: (context, state) {
          return Positioned(
            left: offset.dx,
            top: offset.dy,
            child: Container(
              color: Colors.green,
              width: size.width,
              height: size.height,
              child: content,
            ),
          );
        },
      ),
    );
  }
}
