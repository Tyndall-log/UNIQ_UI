import 'package:flutter/material.dart';
import 'package:uniq_ui/features/tab_view/tab_bar.dart';
import '../../start_page/screen.dart';

class StartPageTab extends TabItem {
  StartPageTab()
      : super(
          tabBar: const Text('시작 페이지'),
          tabContent: const StartPage(),
          icon: Icons.home,
        );
}
