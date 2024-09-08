// state.dart
import 'package:flutter/material.dart';
import '../widgets/project.dart';

//========== WorkspaceViewState Start ==========
sealed class WorkspaceViewState {
  const WorkspaceViewState();
}

class TransformationState extends WorkspaceViewState {
  final Offset offset;
  final double scale;
  final double timeLength;

  const TransformationState(
    this.offset,
    this.scale,
    this.timeLength,
  ) : super();
}

class TransformationInitial extends WorkspaceViewState {
  const TransformationInitial() : super();
}
//========== WorkspaceViewState End ==========

//========== WorkspaceProjectManagerState Start ==========
class WorkspaceProjectManagerState {
  final int workspaceId;
  final List<ProjectCubit> projects = [
    // ProjectCubit(ProjectState(id: 0)),
    // ProjectCubit(ProjectState(id: 1)),
    // ProjectCubit(ProjectState(id: 2)),
  ];

  WorkspaceProjectManagerState({required this.workspaceId});
}
//========== WorkspaceProjectManagerState End ==========
