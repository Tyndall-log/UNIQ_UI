import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniq_ui/common/test/children_controlled_layout.dart';

import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';
import 'package:uniq_ui/features/workspace/widgets/audio_cue.dart';

import '../bloc/state.dart';
import '../default_value.dart';
import 'audio_source.dart';
import 'common_block.dart';

part 'audio_block.freezed.dart';

@freezed
class AudioBlockState with _$AudioBlockState {
  const AudioBlockState._();

  factory AudioBlockState({
    required Id idInfo,
    required Offset offset,
    @Default(0) int audioSourceId,
    @Default(0) int audioCueStartId,
    @Default(0) int audioCueEndId,
  }) = _AudioBlockState;
}

class AudioBlockCubit extends Cubit<AudioBlockState> {
  AudioBlockCubit(super.initialState) {
    var id = state.idInfo.id;
    var workspaceId = state.idInfo.workspaceId;
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'uniq::audio_segment::audio_segment(const shared_ptr<audio_source> &, const shared_ptr<audio_cue> &, const shared_ptr<audio_cue> &)',
      callback: (ApiCallbackMessage callback) {
        var array = callback.dataPtr.cast<ffi.Uint64>();
        var audioSourceId = array[0];
        var audioCueStartId = array[1];
        var audioCueEndId = array[2];
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.resetParentId(parentId: id, id: audioSourceId);
        wwmc?.resetParentId(parentId: id, id: audioCueStartId);
        wwmc?.resetParentId(parentId: id, id: audioCueEndId);
        emit(
          state.copyWith(
              audioSourceId: audioSourceId,
              audioCueStartId: audioCueStartId,
              audioCueEndId: audioCueEndId),
        );
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
}

class AudioBlockWidget extends StatelessWidget {
  final AudioBlockCubit cubit;
  const AudioBlockWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioBlockCubit>(
      create: (context) => cubit,
      child: BlocBuilder<AudioBlockCubit, AudioBlockState>(
        builder: (context, state) {
          var currentTimeLength =
              context.select((WorkspaceViewBloc w) => w.state.timeLength);

          //오디오 길이 계산
          var pairList = context.select((WorkspaceWidgetManagerCubit w) {
            return (w.state.objects[AudioCueCubit] ?? [])
                .where((pair) => pair.parentId == state.idInfo.id)
                .toList();
          });
          var audioCueCubitList = pairList.map((e) => e.cubit).toList();
          Cubit<dynamic> audioCueCubitStart;
          Cubit<dynamic> audioCueCubitEnd;
          int sampleRate;
          try {
            sampleRate = context
                .select((WorkspaceWidgetManagerCubit w) {
                  return (w.state.objects[AudioSourceCubit] ?? [])
                      .where((pair) => pair.parentId == state.idInfo.id)
                      .toList();
                })
                .first
                .cubit
                .state
                .sampleRate;
            audioCueCubitStart = audioCueCubitList.firstWhere(
                (element) => element.state.idInfo.id == state.audioCueStartId);
            audioCueCubitEnd = audioCueCubitList.firstWhere(
                (element) => element.state.idInfo.id == state.audioCueEndId);
          } catch (e) {
            return SizedBox();
          }

          var audioCueStart = audioCueCubitStart.state.point;
          var audioCueEnd = audioCueCubitEnd.state.point;
          var audioLength = audioCueEnd - audioCueStart;

          return SizedBox(
            width: (audioLength / sampleRate) *
                100 /
                currentTimeLength *
                defaultTimeLength,
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
