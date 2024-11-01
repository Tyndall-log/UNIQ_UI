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

part 'audio_source.freezed.dart';

@freezed
class AudioSourceState with _$AudioSourceState {
  const AudioSourceState._();

  factory AudioSourceState({
    required Id idInfo,
    required Offset offset,
    @Default(2) int channel,
    @Default(16) int bitDepth,
    @Default(44100) int sampleRate,
    @Default(44100) int sampleNum,
    @Default("알 수 없음") String name,
    @Default({}) Set<int> cueList,
  }) = _AudioSourceState;
}

class AudioSourceCubit extends Cubit<AudioSourceState> {
  AudioSourceCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'static std::shared_ptr<audio_source> uniq::audio_source::internal::audio_load(unique_ptr<InputStream>, const string &, const string &, const string &)',
      callback: (ApiCallbackMessage callback) {
        var uint32Pointer = callback.dataPtr.cast<ffi.Uint32>();
        var sampleRate = uint32Pointer[0];
        var sampleNum = uint32Pointer[1];
        var channel = uint32Pointer[2];
        var name = (uint32Pointer + 4)
            .cast<ffi.Pointer<ffi.Utf8>>()
            .value
            .toDartString();
        emit(state.copyWith(
          sampleRate: sampleRate,
          sampleNum: sampleNum,
          channel: channel,
          name: name,
        ));
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'bool uniq::audio_source::audio_cue_insert(const std::shared_ptr<audio_cue> &)',
      callback: (ApiCallbackMessage callback) {
        var audioCueId = callback.dataPtr.cast<ffi.Uint64>().value;
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.addParentId(parentId: id, id: audioCueId);
        var newCueList = state.cueList.toSet()..add(audioCueId);
        emit(state.copyWith(cueList: newCueList));
      },
    );
  }

  @override
  Future<void> close() {
    CallbackManager.unregisterCallbackByObjIdAll(state.idInfo.id);
    return super.close();
  }
}

class AudioSourceWidget extends StatelessWidget {
  final AudioSourceCubit cubit;
  const AudioSourceWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioSourceCubit>(
      create: (context) => cubit,
      child: BlocBuilder<AudioSourceCubit, AudioSourceState>(
        builder: (context, state) {
          return SizedBox(
            width: 100,
            height: timelineAudioHeight,
            child: CommonBlock(
              color: Colors.lightBlueAccent.shade100,
              child: Text('0, 0'),
            ),
          );
        },
      ),
    );
  }
}
