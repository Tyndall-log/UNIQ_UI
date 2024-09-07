// state.dart
import 'package:flutter/material.dart';

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
