import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uniq_ui/common/platform.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'default_value.dart';
import 'widgets/grid.dart';
import 'widgets/gesture_detector.dart';
import 'widgets/project.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

class WorkspaceIdCubit extends Cubit<int> {
  WorkspaceIdCubit(super.id);
}

class WorkspaceScreen extends StatefulWidget {
  // final WorkspaceIdCubit workspaceIdCubit;
  final int id;
  WorkspaceScreen({super.key, required this.id});

  @override
  WorkspaceScreenState createState() => WorkspaceScreenState();
}

class WorkspaceScreenState extends State<WorkspaceScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WorkspaceViewBloc(
            workspaceId: widget.id,
            vsync: this,
          ),
        ),
        BlocProvider(
          create: (context) => WorkspaceProjectManagerCubit(
            workspaceId: widget.id,
          ),
        ),
      ],
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
  // final double initialX = 0;
  // final double initialY = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkspaceViewBloc, WorkspaceViewState>(
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
        }

        final wpms = context.watch<WorkspaceProjectManagerCubit>().state;

        return Stack(
          clipBehavior: Clip.hardEdge,
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
                    color: Colors.orange[50],
                    child: CustomPaint(
                      painter: GridPainter(currentTimeLength),
                    ),
                  ),
                ),
              ),
            ),
            for (var i = 0; i < wpms.projects.length; i++)
              BlocProvider.value(
                value: wpms.projects[i],
                child: BlocBuilder<ProjectCubit, ProjectState>(
                  builder: (context, state) {
                    return Positioned(
                      left: (currentX) * currentScale,
                      top: (currentY + 25 * i) * currentScale,
                      child: Text('Project $i'),
                    );
                  },
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
              left: (currentX + 100 * currentTimeScale) * currentScale,
              top: (currentY + 100) * currentScale,
              child: SelectableText(
                '좌표: 100, 100',
                style: TextStyle(fontSize: 14 * currentScale),
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
