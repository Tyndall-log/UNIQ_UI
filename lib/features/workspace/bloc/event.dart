// event.dart
import 'package:flutter/material.dart';

//========== WorkspaceViewEvent Start ==========
sealed class WorkspaceViewEvent {
  const WorkspaceViewEvent();
}

class ScaleStartEvent extends WorkspaceViewEvent {
  final ScaleStartDetails details;

  const ScaleStartEvent(this.details);
}

class ScaleUpdateEvent extends WorkspaceViewEvent {
  final ScaleUpdateDetails details;

  const ScaleUpdateEvent(this.details);
}

class ScaleEndEvent extends WorkspaceViewEvent {
  final ScaleEndDetails details;

  const ScaleEndEvent(this.details);
}

class ScaleTickEvent extends WorkspaceViewEvent {
  final double delta;
  final Offset focalPoint;

  const ScaleTickEvent(this.delta, this.focalPoint);
}

class MoveTickEvent extends WorkspaceViewEvent {
  final Offset offset;

  const MoveTickEvent(this.offset);
}

class TimeScaleTickEvent extends WorkspaceViewEvent {
  final double delta;
  final Offset focalPoint;

  const TimeScaleTickEvent(this.delta, this.focalPoint);
}

class ScaleAnimationEvent extends WorkspaceViewEvent {
  const ScaleAnimationEvent();
}

class TimeScaleStartEvent extends WorkspaceViewEvent {
  final ScaleStartDetails details;

  const TimeScaleStartEvent(this.details);
}

class TimeScaleUpdateEvent extends WorkspaceViewEvent {
  final ScaleUpdateDetails details;

  const TimeScaleUpdateEvent(this.details);
}

class TimeScaleEndEvent extends WorkspaceViewEvent {
  final ScaleEndDetails details;

  const TimeScaleEndEvent(this.details);
}
//========== WorkspaceViewEvent End ==========
