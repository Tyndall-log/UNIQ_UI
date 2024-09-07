import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

export 'model/tab_item.dart';
export 'bloc/bloc.dart';
export 'bloc/event.dart';
export 'bloc/state.dart';

class TabBarView extends StatelessWidget implements PreferredSizeWidget {
  const TabBarView({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return context.read<TabBloc>().buildTabBarView();
  }
}

class TabContentView extends StatelessWidget {
  const TabContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<TabBloc>().buildTabContentView();
  }
}
