import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';
import '../default_value.dart';
import '../widgets/project.dart';

part 'state.freezed.dart';

//========== WorkspaceViewState Start ==========
// sealed class WorkspaceViewState {
//   const WorkspaceViewState();
// }

// class TransformationState extends WorkspaceViewState {
//   final Offset offset;
//   final double scale;
//   final double timeLength;
//
//   const TransformationState(
//     this.offset,
//     this.scale,
//     this.timeLength,
//   ) : super();
// }

// class TransformationInitial extends WorkspaceViewState {
//   const TransformationInitial() : super();
// }

class WorkspaceViewState {
  final Offset offset;
  final double scale;
  final double timeLength;

  const WorkspaceViewState(
    this.offset,
    this.scale,
    this.timeLength,
  ) : super();

  Offset mouseToOffset(Offset mouse) {
    return Offset(
      (mouse.dx / scale - offset.dx) / defaultTimeLength * timeLength,
      mouse.dy / scale - offset.dy,
    );
  }

  double mouseToTime(double mouse) {
    return (mouse / scale - offset.dx) / defaultTimeLength * timeLength;
  }
}
//========== WorkspaceViewState End ==========

//========== WorkspaceManagerState Start ==========

//========== WorkspaceManagerState End ==========

//========== WorkspaceProjectManagerState Start ==========
@freezed
class WorkspaceProjectManagerState with _$WorkspaceProjectManagerState {
  const WorkspaceProjectManagerState._();

  factory WorkspaceProjectManagerState({
    required int workspaceId,
    @Default([]) List<ProjectCubit> projects,
  }) = _WorkspaceProjectManagerState;
}
//========== WorkspaceProjectManagerState End ==========

//========== WorkspaceCubitManagerState Start ==========
class WorkspaceWidgetManagerPair {
  final Widget? widget;
  final Cubit cubit;
  // int parentId;
  List<int> parentIds;

  WorkspaceWidgetManagerPair({
    required this.widget,
    required this.cubit,
    this.parentIds = const [],
  });
}

@freezed
class WorkspaceWidgetManagerState with _$WorkspaceWidgetManagerState {
  const WorkspaceWidgetManagerState._();

  factory WorkspaceWidgetManagerState({
    required int workspaceId,
    @Default({}) Map<int, WorkspaceWidgetManagerPair> widgets,
    // @Default({}) Map<Type, List<WorkspaceWidgetManagerPair>> objects,
    @Default({})
    Map<int, Map<Type, List<WorkspaceWidgetManagerPair>>> parentObjects,
  }) = _WorkspaceWidgetManagerState;
}
//========== WorkspaceCubitManagerState End ==========
