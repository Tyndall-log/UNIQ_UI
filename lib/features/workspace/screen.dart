import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uniq_ui/common/platform.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/features/workspace/widgets/draggable.dart';
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
            initialState: WorkspaceViewState(
              const Offset(0, 0),
              1,
              defaultTimeLength,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => WorkspaceWidgetManagerCubit(
            WorkspaceWidgetManagerState(
              workspaceId: widget.id,
            ),
          ),
        ),
      ],
      child: const Stack(
        children: [
          Positioned.fill(
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
      // buildWhen: (previous, current) {
      //   return false;
      // },
      builder: (context, state) {
        double currentX = state.offset.dx;
        double currentY = state.offset.dy;
        double currentScale = state.scale;
        double currentTimeLength = state.timeLength;
        double currentTimeScale = defaultTimeLength / currentTimeLength;
        Matrix4 matrixOnlyScale = Matrix4.identity()..scale(state.scale);

        // final wwms = context.watch<WorkspaceWidgetManagerCubit>().state;
        final projectList = context.select(
          (WorkspaceWidgetManagerCubit cubit) =>
              cubit.getWidgetCubitList<ProjectCubit>(),
        );
        return DragTarget<WorkspaceDragCubit<ProjectCubit>>(
          builder: (context, candidateData, rejectedData) {
            // print(candidateData);
            // print(rejectedData);
            return Stack(
              // clipBehavior: Clip.none,
              clipBehavior: Clip.hardEdge,
              children: [
                // const SizedBox(
                //   width: double.maxFinite,
                //   height: double.maxFinite,
                // ),
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
                Positioned(
                  left: currentX - 99999999999,
                  top: currentY,
                  width: 1000,
                  height: 800,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 99999999999 -
                            currentX +
                            (currentX + 30000 * currentTimeScale) *
                                currentScale,
                        top: -currentY + (currentY + 200) * currentScale,
                        // child: SelectableText(
                        //   '좌표: 30000, 200',
                        //   style: TextStyle(fontSize: 14 * currentScale),
                        // ),
                        child: Container(
                          width: 10 * currentScale,
                          height: 10 * currentScale,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // for (var i = 0; i < wwms.widgets.length; i++)
                //   if (wwms.widgets[i]?.widget is ProjectWidget)
                //     wwms.widgets[i]?.widget,
                for (var pair in projectList)
                  if (pair.widget is ProjectWidget) pair.widget!,

                // for (var i = 0; i < wpms.timeline.length; i++)
                //   TimelineWidget(cubit: wpms.timeline[i]),
                // BlocProvider.value(
                //   value: wpms.projects[i],
                //   child: BlocBuilder<ProjectCubit, ProjectState>(
                //     builder: (context, state) {
                //       return Positioned(
                //         left: (currentX) * currentScale,
                //         top: (currentY + 25 * i) * currentScale,
                //         child: Text('Project $i'),
                //       );
                //     },
                //   ),
                // ),
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
                    origin:
                        -Offset(currentX + 100 * currentTimeScale, currentY),
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
                  left: currentX + 200 * currentTimeScale,
                  top: currentY + 200,
                  child: Transform(
                    origin: -Offset(
                        currentX + 200 * currentTimeScale, currentY + 200),
                    transform: matrixOnlyScale,
                    child: const Text('좌표: 200, 200'),
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
                Positioned(
                  left: (currentX + 30000 * currentTimeScale) * currentScale,
                  top: (currentY + 100) * currentScale,
                  child: SelectableText(
                    '좌표: 30000, 100',
                    style: TextStyle(fontSize: 14 * currentScale),
                  ),
                ),
              ],
            );
          },
          onWillAcceptWithDetails: (data) {
            return true;
          },
          onAcceptWithDetails: (data) {
            var projectCubit = data.data.state.cubit;
            projectCubit.setOffset(state.mouseToOffset(data.offset) +
                Offset(ProjectGlobal.anchor.dx / currentTimeScale,
                    ProjectGlobal.anchor.dy));
          },
          onLeave: (data) {
            print('onLeave');
          },
        );
      },
    );
  }
}
