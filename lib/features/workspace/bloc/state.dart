// state.dart
import 'package:flutter/material.dart';

sealed class WorkspaceState {
  const WorkspaceState();
}

class TransformationState extends WorkspaceState {
  final Offset offset;
  final double scale;
  final double timeLength;

  const TransformationState(
    this.offset,
    this.scale,
    this.timeLength,
  ) : super();
}

class TransformationInitial extends WorkspaceState {
  const TransformationInitial() : super();
}
