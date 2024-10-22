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
    @Default(44100) int sampleRate,
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
        var SampleRate = callback.dataPtr.cast<ffi.Uint32>().value;
        emit(state.copyWith(sampleRate: SampleRate));
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
