import 'package:flutter/material.dart';
import '../model/tab_item.dart';

class TabState {
  final List<TabItem> tabItems;
  final int currentIndex;
  final int targetIndex;
  final Offset dragPosition;
  final bool tabBarRebuildFlag;
  final bool tabContentRebuildFlag;

  TabState({
    required this.tabItems,
    required this.currentIndex,
    required this.targetIndex,
    this.dragPosition = Offset.zero,
    this.tabBarRebuildFlag = false,
    this.tabContentRebuildFlag = false,
  });

  TabState copyWith({
    List<TabItem>? tabItems,
    int? currentIndex,
    int? targetIndex,
    Offset? dragPosition,
    bool? tabBarRebuildFlag,
    bool? tabContentRebuildFlag,
  }) {
    return TabState(
      tabItems: tabItems ?? this.tabItems,
      currentIndex: currentIndex ?? this.currentIndex,
      targetIndex: targetIndex ?? this.targetIndex,
      dragPosition: dragPosition ?? this.dragPosition,
      tabBarRebuildFlag: tabBarRebuildFlag ?? this.tabBarRebuildFlag,
      tabContentRebuildFlag:
          tabContentRebuildFlag ?? this.tabContentRebuildFlag,
    );
  }
}
