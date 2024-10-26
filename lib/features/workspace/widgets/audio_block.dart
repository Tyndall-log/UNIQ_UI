import 'dart:ffi' as ffi;
import 'dart:math';

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    required Size size,
    @Default("이름 없음") String name,
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
          'uniq::audio_segment::audio_segment(const shared_ptr<audio_source> &, const shared_ptr<audio_cue> &, const shared_ptr<audio_cue> &, const string &)',
      callback: (ApiCallbackMessage callback) {
        var array = callback.dataPtr.cast<ffi.Uint64>();
        var audioSourceId = array[0];
        var audioCueStartId = array[1];
        var audioCueEndId = array[2];
        var name = (callback.dataPtr.cast<ffi.Uint64>() + 3)
            .cast<ffi.Pointer<ffi.Utf8>>()
            .value
            .toDartString();
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.addParentId(parentId: id, id: audioSourceId);
        wwmc?.addParentId(parentId: id, id: audioCueStartId);
        wwmc?.addParentId(parentId: id, id: audioCueEndId);
        emit(
          state.copyWith(
            audioSourceId: audioSourceId,
            audioCueStartId: audioCueStartId,
            audioCueEndId: audioCueEndId,
            name: name,
          ),
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

          // //화면에 보이는지 확인
          // final RenderObject? renderObject = context.findRenderObject();
          // if (renderObject == null) return SizedBox();
          // if (renderObject is RenderBox) {
          //   final position = renderObject.localToGlobal(Offset.zero);
          //   final size = renderObject.size;
          //   if (position.dx + size.width < 0 ||
          //       position.dx > MediaQuery.of(context).size.width) {
          //     return SizedBox();
          //   }
          // }

          //오디오 길이 계산
          var pairList = context.select((WorkspaceWidgetManagerCubit w) {
            return w.getParentWidgetCubitList<AudioCueCubit>(
                parentId: state.idInfo.id);
          });
          var audioCueCubitList = pairList.map((e) => e.cubit).toList();
          Cubit<dynamic> audioCueCubitStart;
          Cubit<dynamic> audioCueCubitEnd;
          int sampleRate;
          try {
            sampleRate = context
                .select((WorkspaceWidgetManagerCubit w) {
                  return w.getParentWidgetCubitList<AudioSourceCubit>(
                      parentId: state.idInfo.id);
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

          var width = (audioLength / sampleRate) *
              100 /
              currentTimeLength *
              defaultTimeLength;

          return SizedBox(
            width: width,
            height: timelineAudioHeight,
            child: CommonBlock(
              color: Colors.lightBlueAccent.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "${state.name}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: WaveWidget(cubit: cubit, width: width),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "2ch·16bit·44.1kHz",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class WaveWidget extends StatefulWidget {
  final double width;
  final AudioBlockCubit cubit;
  const WaveWidget({
    super.key,
    required this.cubit,
    required this.width,
  });

  @override
  State<WaveWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> {
  @override
  Widget build(BuildContext context) {
    // if (widget.cubit.state.idInfo.id >= 1080) return SizedBox();
    var waveData = AudioSegment.waveformGet(
        widget.cubit.state.idInfo.id, widget.width.toInt(), 0);
    return SizedBox(
      width: widget.width,
      child: CustomPaint(
        painter: WavePainter(waveData),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final List<double> data;
  // final double pixelRatio;

  WavePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final midY = size.height / 2;
    final xStep = 1.0;

    var length = min(data.length, size.width ~/ xStep);
    for (int i = 0; i < length; i++) {
      final x = i * xStep + 0.5;
      final y = data[i] * midY;
      canvas.drawLine(Offset(x, midY + y), Offset(x, midY - y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
