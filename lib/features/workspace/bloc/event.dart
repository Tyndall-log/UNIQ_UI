// event.dart
import 'package:flutter/material.dart';

sealed class WorkspaceEvent {
  const WorkspaceEvent();
}

class ScaleStartEvent extends WorkspaceEvent {
  final ScaleStartDetails details;

  const ScaleStartEvent(this.details);
}

class ScaleUpdateEvent extends WorkspaceEvent {
  final ScaleUpdateDetails details;

  const ScaleUpdateEvent(this.details);
}

class ScaleEndEvent extends WorkspaceEvent {
  final ScaleEndDetails details;

  const ScaleEndEvent(this.details);
}

class ScaleAnimationEvent extends WorkspaceEvent {
  const ScaleAnimationEvent();
}

class TimeScaleStartEvent extends WorkspaceEvent {
  final ScaleStartDetails details;

  const TimeScaleStartEvent(this.details);
}

class TimeScaleUpdateEvent extends WorkspaceEvent {
  final ScaleUpdateDetails details;

  const TimeScaleUpdateEvent(this.details);
}

class TimeScaleEndEvent extends WorkspaceEvent {
  final ScaleEndDetails details;

  const TimeScaleEndEvent(this.details);
}
