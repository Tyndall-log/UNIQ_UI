import 'dart:ffi' as ffi;
import 'dart:ui' as ui;
import 'dart:math';

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniq_ui/common/overlay/window.dart';
import 'package:uniq_ui/common/test/children_controlled_layout.dart';

import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';
import 'package:uniq_ui/features/workspace/widgets/audio_cue.dart';
import 'package:uniq_ui/features/workspace/widgets/timeline_cue.dart';
import 'package:uniq_ui/features/workspace/widgets/timeline_group.dart';

import '../bloc/state.dart';
import '../default_value.dart';
import '../window/audio_editer.dart';
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
        // wwmc?.getWidgetCubit<AudioCueCubit>(audioCueStartId).addCallback(
        //   () {
        //     emit(state.copyWith(
        //       size: Size(
        //         (state.size.width *
        //                 (audioCueEndId - audioCueStartId) /
        //                 (audioCueEndId - audioCueStartId)) *
        //             100,
        //         state.size.height,
        //       ),
        //     ));
        //   },
        // );
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
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'void uniq::audio_segment::start_cue_change(const shared_ptr<audio_cue> &)',
      callback: (ApiCallbackMessage callback) {
        var pointer = callback.dataPtr.cast<ffi.Uint64>();
        var prevId = pointer[0];
        var newId = pointer[1];
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.removeParentId(id: prevId, parentId: id);
        wwmc?.addParentId(parentId: id, id: newId);
        if (state.audioCueStartId == prevId) {
          emit(state.copyWith(audioCueStartId: newId));
        }
      },
    );
    CallbackManager.registerCallback(
      workspaceId: workspaceId,
      objId: id,
      funcIdName:
          'void uniq::audio_segment::end_cue_change(const shared_ptr<audio_cue> &)',
      callback: (ApiCallbackMessage callback) {
        var pointer = callback.dataPtr.cast<ffi.Uint64>();
        var prevId = pointer[0];
        var newId = pointer[1];
        var wwmc = WorkspaceWidgetManagerCubit.getInstance(workspaceId);
        wwmc?.removeParentId(id: prevId, parentId: id);
        wwmc?.addParentId(parentId: id, id: newId);
        if (state.audioCueEndId == prevId) {
          emit(state.copyWith(audioCueEndId: newId));
        }
      },
    );
  }

  void setOffset(Offset offset) {
    emit(state.copyWith(offset: offset));
  }

  void setSize(Size size) {
    emit(state.copyWith(size: size));
  }

  @override
  Future<void> close() {
    // print("AudioBlockCubit close");
    CallbackManager.unregisterCallbackByObjIdAll(state.idInfo.id);
    return super.close();
  }
}

class AudioBlockWidget extends StatelessWidget {
  final AudioBlockCubit cubit;
  const AudioBlockWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioBlockCubit>.value(
      value: cubit,
      child: BlocBuilder<AudioBlockCubit, AudioBlockState>(
        builder: (context, state) {
          var wvbR = context.read<WorkspaceViewBloc>();
          var currentTimeLength =
              context.select((WorkspaceViewBloc w) => w.state.timeLength);
          var currentOffset =
              context.select((WorkspaceViewBloc w) => w.state.offset);
          var currentX = currentOffset.dx;
          var currentY = currentOffset.dy;
          var currentScale =
              context.select((WorkspaceViewBloc w) => w.state.scale);
          var currentTimeScale = defaultTimeLength / currentTimeLength;

          // //화면에 보이는지 확인(renderObject 기반)
          // final RenderObject? renderObject = context.findRenderObject();
          // if (renderObject == null) return const SizedBox();
          // if (renderObject is RenderBox) {
          //   final position = renderObject.localToGlobal(Offset.zero);
          //   final size = renderObject.size;
          //   if (position.dx + size.width < 0 ||
          //       position.dx > MediaQuery.of(context).size.width) {
          //     return const SizedBox();
          //   }
          // }

          //오디오 길이 계산
          var audioCueCubitPairList =
              context.select((WorkspaceWidgetManagerCubit w) {
            return w.getParentWidgetCubitList<AudioCueCubit>(
                parentId: state.idInfo.id);
          });
          var audioCueCubitList =
              audioCueCubitPairList.map((e) => e.cubit).toList();
          AudioCueCubit audioCueCubitStart;
          AudioCueCubit audioCueCubitEnd;
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
            audioCueCubitStart = audioCueCubitList.firstWhere((element) =>
                    element.state.idInfo.id == state.audioCueStartId)
                as AudioCueCubit;
            audioCueCubitEnd = audioCueCubitList.firstWhere(
                    (element) => element.state.idInfo.id == state.audioCueEndId)
                as AudioCueCubit;
          } catch (e) {
            print("AudioBlockWidget error: $e");
            return const SizedBox();
          }

          var audioCueStart = audioCueCubitStart.state.point;
          var audioCueEnd = audioCueCubitEnd.state.point;
          var audioLength = audioCueEnd - audioCueStart;

          double width2 = (audioLength / sampleRate) * 100;
          double width = (audioLength / sampleRate) *
              100 /
              currentTimeLength *
              defaultTimeLength;

          final position = state.offset;
          // final size = cubit.state.size;
          // print(
          //     "AudioBlockWidget ${state.idInfo.id} ${position.dx} ${size.width}");

          // TEST
          // double test = 100;
          double test = 0;
          if (position.dx + width2 < wvbR.mouseToTime(0 + test) ||
              position.dx >
                  wvbR.mouseToTime(MediaQuery.of(context).size.width - test)) {
            return const SizedBox();
          }
          // state.size = Size(width, timelineAudioHeight);
          // var timelineGroupCubit = context.read<TimelineGroupCubit>();
          // var startCueId = timelineGroupCubit.state.startCueId;
          // var timelineCueStart =
          //     WorkspaceWidgetManagerCubit.getInstance(state.idInfo.workspaceId)!
          //         .getWidgetCubit<TimelineCueCubit>(startCueId)
          //         .state
          //         .point;
          // double left = (timelineCueStart / sampleRate) *
          //         100 /
          //         currentTimeLength *
          //         defaultTimeLength +
          //     state.offset.dx;

          return SizedBox(
            width: width,
            height: timelineAudioHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTap: () {
                var overlayState = Overlay.of(context);
                window(
                  overlayState: overlayState,
                  x: 100,
                  y: 100,
                  width: 700,
                  height: 500,
                  title: "오디오 편집기",
                  content: AudioEditorView(
                    workspaceWidgetManagerCubit:
                        WorkspaceWidgetManagerCubit.getInstance(
                            state.idInfo.workspaceId)!,
                    audioSourceCubit: context
                        .read<WorkspaceWidgetManagerCubit>()
                        .getWidgetCubit<AudioSourceCubit>(state.audioSourceId),
                  ),
                );
              },
              child: CommonBlock(
                color: Colors.lightBlueAccent.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        state.name,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Expanded(
                      child: WaveWidget(cubit: cubit, width: width),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "2ch·16bit·44.1kHz",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
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
    // var currentTimeLength = context.read<WorkspaceViewBloc>().state.timeLength;
    // var currentTimeScale = defaultTimeLength / currentTimeLength;
    var currentScale = context.read<WorkspaceViewBloc>().state.scale;
    final dpr = ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    var waveData = AudioSegment.waveformGet(widget.cubit.state.idInfo.id,
        (widget.width * currentScale * dpr).toInt() + 2, 0);
    var waveData2 = AudioSegment.waveformGet(widget.cubit.state.idInfo.id,
        (widget.width * currentScale * dpr).toInt() + 2, 1);
    // List<double> waveData2 = [];
    return SizedBox(
      width: widget.width,
      child: CustomPaint(
        painter: WavePainter([waveData, waveData2], 1.0 / currentScale / dpr),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final List<List<double>> data;
  final double xStep;

  WavePainter(this.data, this.xStep);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final channelCount = data.length;
    final midY = size.height / channelCount / 2;
    // final xStep = size.width / (data[0].length - 1);
    final yStep = size.height / channelCount;

    for (int channel = 0; channel < channelCount; channel++) {
      final path = Path();
      for (int i = 0; i < data[channel].length; i++) {
        final x = i * xStep;
        final y = data[channel][i] * midY;
        path.lineTo(x, midY + yStep * channel - y);
      }
      for (int i = data[channel].length - 1; i >= 0; i--) {
        final x = i * xStep;
        final y = data[channel][i] * midY;
        path.lineTo(x, midY + yStep * channel + y);
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
