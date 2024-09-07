import 'package:flutter/material.dart';

import '../bloc/bloc.dart';

class TabItem {
  final Widget tabBar;
  final Widget tabContent;
  final Future<bool> Function(TabBloc)? onClose;
  final IconData icon;
  final GlobalKey tabBarKey = GlobalKey();
  final GlobalKey tabContentKey = GlobalKey();

  TabItem({
    required this.tabBar,
    required this.tabContent,
    this.onClose,
    this.icon = Icons.web,
  });
}
