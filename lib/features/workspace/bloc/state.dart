import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';
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
}
//========== WorkspaceViewState End ==========

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
