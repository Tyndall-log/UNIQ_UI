import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniq_ui/features/workspace/bloc/bloc.dart';
import 'package:uniq_ui/features/workspace/bloc/state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'draggable.freezed.dart';

@freezed
class WorkspaceDragState<T> with _$WorkspaceDragState<T> {
  const WorkspaceDragState._();
  factory WorkspaceDragState({
    required T cubit,
    required Offset offset,
    required Size size,
  }) = _WorkspaceDragState;
}

class WorkspaceDragCubit<T> extends Cubit<WorkspaceDragState<T>> {
  WorkspaceDragCubit(super.initialState);

  void setOffset(Offset offset) => emit(state.copyWith(offset: offset));
}

class WorkspaceDraggable<T> extends StatelessWidget {
  const WorkspaceDraggable({
    super.key,
    // required this.projectDragCubit,
    required this.cubit,
    required this.child,
    this.autoScale = true,
  });

  // final ProjectDragCubit projectDragCubit;
  final WorkspaceDragCubit<T> cubit;
  final Widget child;
  final bool autoScale;

  @override
  Widget build(BuildContext context) {
    var wvb = context.watch<WorkspaceViewBloc>();
    var currentScale =
        context.select((WorkspaceViewBloc value) => value.state.scale);
    WorkspaceWidgetManagerCubit wwmc =
        context.read<WorkspaceWidgetManagerCubit>();
    return DraggableWithCancel<WorkspaceDragCubit<T>>(
      data: cubit,
      feedback: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: wvb,
          ),
          BlocProvider.value(
            value: wwmc,
          ),
          BlocProvider.value(
            value: cubit,
          ),
        ],
        child: BlocBuilder<WorkspaceViewBloc, WorkspaceViewState>(
            builder: (context, state) {
          var workspaceDragState = context.watch<WorkspaceDragCubit<T>>().state;
          return Opacity(
            opacity: 0.8,
            child: autoScale
                ? Transform(
                    // origin: ProjectGlobal.anchor,
                    // origin: projectDragState.offset,
                    transform: Matrix4.identity()..scale(state.scale),
                    child: Material(
                      color: Colors.transparent,
                      child: child,
                    ),
                  )
                : Material(
                    color: Colors.transparent,
                    child: child,
                  ),
          );
        }),
      ),
      dragAnchorStrategy: (draggable, context, position) {
        final RenderBox renderObject = context.findRenderObject()! as RenderBox;
        Offset offset = renderObject.globalToLocal(position);
        cubit.setOffset(offset);
        return autoScale ? offset * currentScale : offset;
      },
      feedbackOffset: Offset.zero,
      delay: const Duration(milliseconds: 200),
      childWhenDragging: Opacity(
        opacity: 0.2,
        child: child,
      ),
      onDragUpdate: (details) {
        // print(details.globalPosition);
      },
      child: child,
    );
  }
}

//https://github.com/flutter/flutter/issues/111171

class DraggableWithCancel<T extends Object> extends LongPressDraggable {
  const DraggableWithCancel({
    super.key,
    required super.child,
    required super.feedback,
    super.data,
    super.axis,
    super.childWhenDragging,
    super.feedbackOffset = Offset.zero,
    super.dragAnchorStrategy = childDragAnchorStrategy,
    super.delay = kLongPressTimeout,
    super.maxSimultaneousDrags,
    super.onDragStarted,
    super.onDragUpdate,
    super.onDraggableCanceled,
    super.onDragEnd,
    super.onDragCompleted,
    super.ignoringFeedbackSemantics = true,
    super.ignoringFeedbackPointer = true,
    super.rootOverlay = false,
    super.hitTestBehavior = HitTestBehavior.deferToChild,
    super.allowedButtonsFilter,
  });

  @override
  DelayedMultiDragGestureRecognizer createRecognizer(
      GestureMultiDragStartCallback onStart) {
    DelayedMultiDragGestureRecognizer recognizer =
        DelayedMultiDragGestureRecognizerWithCancel(
      delay: delay,
      allowedButtonsFilter: allowedButtonsFilter,
    )..onStart = (Offset position) {
            final Drag? result = onStart(position);
            if (result != null && hapticFeedbackOnStart) {
              HapticFeedback.selectionClick();
            }
            return result;
          };
    return recognizer;
  }
}

class DelayedMultiDragGestureRecognizerWithCancel
    extends DelayedMultiDragGestureRecognizer {
  final Set<int> _pointerIds = <int>{};
  bool _isDragging = false;

  DelayedMultiDragGestureRecognizerWithCancel({
    super.delay = kLongPressTimeout,
    super.debugOwner,
    super.supportedDevices,
    super.allowedButtonsFilter,
  }) {
    _setupKeyboardListener();
  }

  void _setupKeyboardListener() {
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape &&
        _isDragging) {
      _cancelDrag();
      return true; // Event handled
    }
    return false; // Event not handled
  }

  void _cancelDrag() {
    for (final pointerId in _pointerIds) {
      GestureBinding.instance.pointerRouter.route(PointerCancelEvent(
        pointer: pointerId,
      ));
    }
    _isDragging = false;
    _pointerIds.clear();
  }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    _pointerIds.add(event.pointer);
    _isDragging = true;
    super.addAllowedPointer(event);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.dispose();
  }
}
