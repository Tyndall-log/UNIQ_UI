import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/widgets/audio_source.dart';

import '../bloc/bloc.dart';
import '../widgets/audio_cue.dart';
import '../widgets/project.dart';

part 'audio_editer.freezed.dart';

class AudioEditorView extends StatefulWidget {
  final WorkspaceWidgetManagerCubit workspaceWidgetManagerCubit;
  final AudioSourceCubit? audioSourceCubit;
  const AudioEditorView(
      {super.key,
      required this.workspaceWidgetManagerCubit,
      this.audioSourceCubit});

  @override
  State<AudioEditorView> createState() => _AudioEditorViewState();
}

class _AudioEditorViewState extends State<AudioEditorView> {
  late final TreeController<AudioSourceNode> treeController;
  late final List<AudioSourceNode> roots;
  late final AudioSourceViewCubit audioSourceViewCubit;

  @override
  void initState() {
    super.initState();
    roots = <AudioSourceNode>[];
    var projectPairList =
        widget.workspaceWidgetManagerCubit.getWidgetCubitList<ProjectCubit>();
    for (var projectPair in projectPairList) {
      var projectCubit = projectPair.cubit as ProjectCubit;
      var audioSourcePairList = widget.workspaceWidgetManagerCubit
          .getParentWidgetCubitList<AudioSourceCubit>(
        parentId: projectCubit.state.idInfo.id,
      );
      var tempNodeList = <AudioSourceNode>[];
      for (var audioSourcePair in audioSourcePairList) {
        var audioSourceCubit = audioSourcePair.cubit as AudioSourceCubit;
        tempNodeList.add(AudioSourceNode(
          title: audioSourceCubit.state.name,
          audioSourceCubit: audioSourceCubit,
        ));
      }
      roots.add(AudioSourceNode(
        title: projectCubit.state.title,
        children: tempNodeList,
      ));
    }
    treeController = TreeController<AudioSourceNode>(
      roots: roots,
      childrenProvider: (AudioSourceNode node) => node.children,
    );
    audioSourceViewCubit = AudioSourceViewCubit(
      AudioSourceViewState(
        audioSourceCubit: widget.audioSourceCubit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 200,
          child: AnimatedTreeView<AudioSourceNode>(
            treeController: treeController,
            nodeBuilder:
                (BuildContext context, TreeEntry<AudioSourceNode> entry) {
              return AudioSourceTile(
                entry: entry,
                onTap: entry.node.audioSourceCubit == null
                    ? () {
                        treeController.toggleExpansion(entry.node);
                      }
                    : () {
                        var audioSourceCubit = entry.node.audioSourceCubit!;
                        audioSourceViewCubit
                            .setAudioSourceCubit(audioSourceCubit);
                        audioSourceViewCubit.setPosition(0);
                        audioSourceViewCubit.setLevel(8);
                      },
              );
            },
          ),
        ),
        //경계
        const VerticalDivider(
          width: 20,
          thickness: 1,
          color: Colors.black38,
        ),
        Expanded(
          child: AudioSourceViewWidget(
            audioSourceViewCubit: audioSourceViewCubit,
            workspaceWidgetManagerCubit: widget.workspaceWidgetManagerCubit,
          ),
        ),
      ],
    );
  }
}

class AudioSourceNode {
  final String title;
  final List<AudioSourceNode> children;
  final bool folder;
  final AudioSourceCubit? audioSourceCubit;

  const AudioSourceNode({
    required this.title,
    this.folder = true,
    this.audioSourceCubit,
    this.children = const <AudioSourceNode>[],
  });
}

class AudioSourceTile extends StatelessWidget {
  const AudioSourceTile({
    super.key,
    required this.entry,
    required this.onTap,
  });

  final TreeEntry<AudioSourceNode> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TreeIndentation(
        entry: entry,
        guide: const IndentGuide.connectingLines(indent: 48),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
          child: Row(
            children: [
              if (entry.hasChildren)
                ExpandIcon(
                  isExpanded: entry.isExpanded,
                  onPressed: (_) {
                    onTap();
                  },
                ),
              SizedBox(
                width: 140,
                child: Text(
                  entry.node.title,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@freezed
class AudioSourceViewState with _$AudioSourceViewState {
  const AudioSourceViewState._();
  const factory AudioSourceViewState({
    @Default(0) double position, // 샘플 위치
    // required double scale,
    @Default(8) double level, // 샘플 크기
    AudioSourceCubit? audioSourceCubit,
  }) = _AudioSorceViewState;
}

class AudioSourceViewCubit extends Cubit<AudioSourceViewState> {
  AudioSourceViewCubit(super.initialState);

  void setAudioSourceCubit(AudioSourceCubit audioSourceCubit) {
    emit(state.copyWith(audioSourceCubit: audioSourceCubit));
  }

  void setPosition(double position) {
    emit(state.copyWith(position: position));
  }

  void setLevel(double level) {
    emit(state.copyWith(level: level));
  }

  void addPosition(double position) {
    var pos = state.position;
    pos = math.max(0.0, pos + position);
    if (state.audioSourceCubit != null) {
      var sampleNum = state.audioSourceCubit!.state.sampleNum;
      pos = math.min(pos, sampleNum.toDouble());
    }
    emit(state.copyWith(position: pos));
  }

  void addLevel(double level) {
    emit(state.copyWith(level: state.level + level));
  }
}

class AudioSourceViewWidget extends StatelessWidget {
  final AudioSourceViewCubit audioSourceViewCubit;
  final WorkspaceWidgetManagerCubit workspaceWidgetManagerCubit;
  const AudioSourceViewWidget(
      {super.key,
      required this.audioSourceViewCubit,
      required this.workspaceWidgetManagerCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: audioSourceViewCubit,
      child: BlocBuilder<AudioSourceViewCubit, AudioSourceViewState>(
        builder: (context, state) {
          List<AudioCueCubit> audioCuePairList = [];
          var audioSourceCubit = audioSourceViewCubit.state.audioSourceCubit;
          if (audioSourceCubit != null) {
            var audioCueList = workspaceWidgetManagerCubit
                .getParentWidgetCubitList<AudioCueCubit>(
              parentId: audioSourceCubit.state.idInfo.id,
            );
            audioCuePairList =
                audioCueList.map((e) => e.cubit as AudioCueCubit).toList();
          }
          var level = state.level;
          return Stack(
            children: [
              if (state.audioSourceCubit != null) ...[
                Positioned.fill(
                  child: AudioSourceWaveFromWidget(
                    cubit: audioSourceViewCubit,
                  ),
                ),
                Positioned(
                  top: 20,
                  bottom: 20,
                  left: 100,
                  width: 1,
                  child: VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Colors.indigoAccent,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 20,
                      child: Slider(
                        value: state.position,
                        min: 0,
                        max: state.audioSourceCubit?.state.sampleNum
                                .toDouble() ??
                            0.0,
                        onChanged: (value) {
                          audioSourceViewCubit.setPosition(value);
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
                for (var audioCueCubit in audioCuePairList)
                  Positioned(
                    left: 100 +
                        (audioCueCubit.state.point.toDouble() -
                                state.position) /
                            math.pow(2, level),
                    top: 0,
                    bottom: 0,
                    child: AudioCueLine(cubit: audioCueCubit),
                  ),
              ],
              if (state.audioSourceCubit == null)
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('오디오를 선택해주세요'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class AudioSourceWaveFromWidget extends StatelessWidget {
  final AudioSourceViewCubit cubit;
  const AudioSourceWaveFromWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        bool isCtrlPressed = HardwareKeyboard.instance.isControlPressed;
        if (event is PointerScrollEvent) {
          if (isCtrlPressed) {
            var deltaLevel = event.scrollDelta.dy / 500;
            var pos = event.localPosition.dx;
            var level = cubit.state.level;
            cubit.addLevel(deltaLevel);
            // cubit.addPosition((pos - 100) * math.log(deltaLevel));
          } else {
            var level = cubit.state.level;
            cubit.addPosition(event.scrollDelta.dy * math.pow(2, level) / 5);
          }
        }
      },
      child: GestureDetector(
        onPanUpdate: (details) {
          var level = cubit.state.level;
          cubit.addPosition(-details.delta.dx * math.pow(2, level));
        },
        onTapDown: (details) {
          print('onTapDown');
          var mousePosition = details.localPosition.dx;
          mousePosition -= 100;
          var position = cubit.state.position;
          var level = cubit.state.level;
          var samplePosition = position + mousePosition * math.pow(2, level);
          // print('samplePosition: $samplePosition');
          AudioSource.audioSourceCueAdd(
            cubit.state.audioSourceCubit!.state.idInfo.id,
            samplePosition.toInt(),
          );
        },
        child: CustomPaint(
          painter: WavePainter(cubit),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final AudioSourceViewCubit cubit;
  final double anchor = 100.0;

  WavePainter(this.cubit);

  @override
  void paint(Canvas canvas, Size size) {
    AudioSourceCubit audioSourceCubit = cubit.state.audioSourceCubit!;
    var currentLevel = cubit.state.level;
    var currentScale = math.pow(2, currentLevel);
    final dpr = ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    var position = cubit.state.position;
    var start = (position - anchor * currentScale).toInt();
    var end = (position + (size.width - anchor) * currentScale).toInt() + 1;
    List<List<double>> data = [];
    var channelLength = audioSourceCubit.state.channel;
    for (int channel = 0; channel < channelLength; channel++) {
      data.add(AudioSource.audioSourceWaveformGetPart(
        audioSourceCubit.state.idInfo.id,
        start,
        end,
        (size.width * dpr).toInt(),
        channel,
      ));
    }
    var xStep = 1.0 / dpr;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final channelCount = data.length;
    final midY = size.height / channelLength / 2;
    // final xStep = size.width / (data[0].length - 1);
    final yStep = size.height / channelLength;

    for (int channel = 0; channel < channelLength; channel++) {
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
    return true;
  }
}

class AudioCueLine extends StatelessWidget {
  final AudioCueCubit cubit;

  const AudioCueLine({
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
      child: Container(
        color: Colors.green,
      ),
    );
  }
}
