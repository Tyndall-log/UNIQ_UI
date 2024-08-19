import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniq_ui/common/platform.dart';
import 'default_value.dart';
import 'widgets/grid.dart';
import 'widgets/gesture_detector.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({super.key});

  @override
  _WorkspaceScreenState createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkspaceBloc(this),
      child: const Stack(
        children: [
          Positioned.fill(
            left: 0,
            top: 0,
            child: WorkspaceGestureDetector(
              child: Bb2(),
            ),
          ),
        ],
      ),
    );
  }
}

class Bb2 extends StatelessWidget {
  const Bb2({
    super.key,
  });

  // final initialOffset = const Offset(1e+6, 1e+6);
  final double initialX = 0;
  final double initialY = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkspaceBloc, WorkspaceState>(
      builder: (context, state) {
        double currentX = 0;
        double currentY = 0;
        double currentScale = 1;
        double currentTimeLength = defaultTimeLength; // 10ms (ns/pixel)
        double currentTimeScale = 1;
        Matrix4 matrixOnlyScale = Matrix4.identity();

        if (state is TransformationState) {
          currentX = state.offset.dx;
          currentY = state.offset.dy;
          currentScale = state.scale;
          currentTimeLength = state.timeLength;
          currentTimeScale = defaultTimeLength / currentTimeLength;
          matrixOnlyScale.scale(state.scale);
          // print('Scale: ${state.scale}');
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
            ),
            Positioned(
              left: currentX,
              top: currentY,
              child: Transform(
                origin: Offset(-currentX, -currentY),
                transform: matrixOnlyScale,
                child: RepaintBoundary(
                  child: Container(
                    width: 30000 * currentTimeScale, //(300s = 5m)
                    height: 1000,
                    color: Colors.green[50],
                    child: CustomPaint(
                      painter: GridPainter(currentTimeLength),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: currentX,
              top: currentY,
              child: Transform(
                origin: Offset(-currentX, -currentY),
                transform: matrixOnlyScale,
                child: const SelectableText(
                  '좌표: 0, 0',
                ),
              ),
            ),
            Positioned(
              left: currentX * currentScale,
              top: (currentY + 100) * currentScale,
              child: SelectableText(
                '좌표: 0, 100',
                style: TextStyle(fontSize: 14 * currentScale),
              ),
            ),
            Positioned(
              left: currentX + 100 * currentTimeScale,
              top: currentY,
              child: Transform(
                origin: -Offset(currentX + 100 * currentTimeScale, currentY),
                transform: matrixOnlyScale,
                child: const Text('좌표: 100, 0'),
              ),
            ),
            Positioned(
              left: currentX - 10,
              top: currentY + 990,
              child: Transform(
                origin: Offset(-currentX + 10, -currentY - 990),
                transform: matrixOnlyScale,
                child: const SelectableText(
                  '좌표: -10, 990',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
