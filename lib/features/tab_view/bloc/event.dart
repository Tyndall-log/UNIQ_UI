import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../model/tab_item.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object> get props => [];
}

class AddTab extends TabEvent {
  final TabItem tabItem;

  const AddTab({required this.tabItem});

  @override
  List<Object> get props => [tabItem];
}

class ReplaceTab extends TabEvent {
  final int index;
  final TabItem tabItem;

  const ReplaceTab({required this.index, required this.tabItem});

  @override
  List<Object> get props => [index, tabItem];
}

class RemoveTab extends TabEvent {
  final int index;

  const RemoveTab({required this.index});

  @override
  List<Object> get props => [index];
}

class MoveTab extends TabEvent {
  final int oldIndex;
  final int newIndex;

  const MoveTab({required this.oldIndex, required this.newIndex});

  @override
  List<Object> get props => [oldIndex, newIndex];
}

class AnimateToTab extends TabEvent {
  final int index;

  const AnimateToTab({required this.index});

  @override
  List<Object> get props => [index];
}

class DragTab extends TabEvent {
  final Offset position;

  const DragTab({required this.position});

  @override
  List<Object> get props => [position];
}

class ChangeCurrentIndex extends TabEvent {
  final int index;

  const ChangeCurrentIndex({required this.index});

  @override
  List<Object> get props => [index];
}

class ChangeTargetIndex extends TabEvent {
  final int index;

  const ChangeTargetIndex({required this.index});

  @override
  List<Object> get props => [index];
}

class TabBarNeedRebuild extends TabEvent {}

class TabBarCompletedRebuild extends TabEvent {}

class TabContentNeedRebuild extends TabEvent {}

class TabContentCompletedRebuild extends TabEvent {}

class ClearTabs extends TabEvent {}
