import 'dart:math';
import 'package:flutter/material.dart';

class TabItem {
  final Widget tabBar;
  final Widget tabContent;
  final Future<bool> Function()? onClose;
  final IconData icon;
  final GlobalKey key = GlobalKey();
  TabItem({
    required this.tabBar,
    required this.tabContent,
    this.onClose,
    this.icon = Icons.web,
  });
}

class TabConnector {
  final PageController _pageController = PageController();
  final List<TabItem> _tabItems = [];
  final GlobalKey _listViewKey = GlobalKey();
  int _draggingTabId = -1;
  int _currentTabIndex = 0;
  int _targetTabIndex = 0;
  Offset _mousePosition = Offset.zero;
  Offset _mouseStartPosition = Offset.zero;
  Offset _feedBackOffset = Offset.zero;
  void Function(void Function())? _tabBarStateSetState;
  void Function(void Function())? _tabContentStateSetState;
  void Function()? _tabAddCallback;
  double _height = 0;
  bool needRebuild = false;

  TabConnector({double height = kToolbarHeight}) {
    _height = height;
  }

  void addTab(TabItem tabItem) {
    _tabItems.add(tabItem);
  }

  void removeTab(int index) {
    if (_tabItems.length == 1) return;
    if (index <= _targetTabIndex) {
      if (index == _targetTabIndex) {
        animateToTab(_targetTabIndex - 1);
      } else {
        _pageController.jumpToPage(_targetTabIndex - 1);
        _targetTabIndex--;
      }

      _tabBarStateSetState!(() {});
      _tabContentStateSetState!(() {});
    }

    _tabItems.removeAt(index);
  }

  void moveTab(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;
    final item = _tabItems.removeAt(oldIndex);
    _tabItems.insert(newIndex, item);

    if (oldIndex <= _currentTabIndex && _currentTabIndex <= newIndex) {
      if (oldIndex == _currentTabIndex) {
        _currentTabIndex = newIndex;
      } else {
        _currentTabIndex--;
      }
    } else if (newIndex <= _currentTabIndex && _currentTabIndex <= oldIndex) {
      if (oldIndex == _currentTabIndex) {
        _currentTabIndex = newIndex;
      } else {
        _currentTabIndex++;
      }
    }
    if (oldIndex <= _targetTabIndex && _targetTabIndex <= newIndex) {
      if (oldIndex == _targetTabIndex) {
        _targetTabIndex = newIndex;
      } else {
        _targetTabIndex--;
      }
    } else if (newIndex <= _targetTabIndex && _targetTabIndex <= oldIndex) {
      if (oldIndex == _targetTabIndex) {
        _targetTabIndex = newIndex;
      } else {
        _targetTabIndex++;
      }
    }
    if (_currentTabIndex == _targetTabIndex) {
      _pageController.jumpToPage(_targetTabIndex);
    } else {
      animateToTab(_targetTabIndex);
    }
    _draggingTabId = newIndex;
    _tabBarStateSetState!(() {});
    _tabContentStateSetState!(() {});
  }

  void animateToTab(int index) {
    _targetTabIndex = index;
    int duration = (log((index - _currentTabIndex).abs() + 4) * 150).toInt();
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOut,
    );
  }

  void clear() {
    _tabItems.clear();
  }

  void dispose() {
    _pageController.dispose();
  }

  void registerAddCallback(void Function() fn) {
    _tabAddCallback = fn;
  }

  void setState(void Function() fn) {
    _tabBarStateSetState!(fn);
    _tabContentStateSetState!(fn);
  }

  Widget buildTabBarView() {
    needRebuild = false;
    return Listener(
      onPointerDown: (event) {
        _tabBarStateSetState!(() {});
      },
      onPointerMove: (event) {
        // print('onPointerMove');
        _mousePosition = event.position;
        if (needRebuild) return;
        needRebuild = true;
        if (_draggingTabId == -1) return;
        _tabBarStateSetState!(() {});
        final RenderBox listBox =
            _listViewKey.currentContext!.findRenderObject() as RenderBox;
        final Offset localOffset = listBox.globalToLocal(_mousePosition);
        int newIndex = _getTabBarIndex(localOffset);
        if (newIndex == _draggingTabId) return;
        moveTab(_draggingTabId, newIndex);
      },
      onPointerUp: (event) {
        _draggingTabId = -1;
        _tabBarStateSetState!(() {});
        _tabContentStateSetState!(() {});
      },
      child: SizedBox(
        height: _height,
        child: Stack(
          children: [
            ListView.builder(
              key: _listViewKey,
              scrollDirection: Axis.horizontal,
              itemCount: _tabItems.length + 1,
              itemBuilder: (context, index) {
                if (index != _tabItems.length) {
                  return Visibility(
                    visible: _draggingTabId != index,
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    child: _buildTab(index, false),
                  );
                }
                if (_tabAddCallback != null) {
                  return SizedBox(
                    width: 30,
                    child: Center(
                      child: IconButton(
                        iconSize: 22,
                        padding: const EdgeInsets.all(3),
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _tabAddCallback!();
                          _tabBarStateSetState!(() {});
                          _tabContentStateSetState!(() {});
                        },
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            if (_draggingTabId != -1)
              Positioned(
                left: _mousePosition.dx - _feedBackOffset.dx,
                top: _mouseStartPosition.dy - _feedBackOffset.dy,
                child: SizedBox(
                  height: _height,
                  child: _buildTab(_draggingTabId, true, isFeedBack: true),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTabContentView() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        _currentTabIndex = index;
        _tabBarStateSetState!(() {});
      },
      children: _tabItems.map((e) => e.tabContent).toList(),
    );
  }

  int _getTabBarIndex(Offset offset) {
    final RenderBox nowTabBox = _tabItems[_draggingTabId]
        .key
        .currentContext!
        .findRenderObject() as RenderBox;
    const double threshold = 10;
    final left = offset.dx - _feedBackOffset.dx + threshold;
    final right = left + nowTabBox.size.width - threshold;
    var result = _draggingTabId;
    //왼쪽 검사
    for (int i = result - 1; i >= 0; i--) {
      final RenderBox tabBox =
          _tabItems[i].key.currentContext!.findRenderObject() as RenderBox;
      final Offset tabPosition = tabBox.localToGlobal(Offset.zero);
      final Size tabSize = tabBox.size;
      final tabCenter = tabPosition.dx + tabSize.width / 2;
      if (tabCenter < left) {
        break;
      }
      result = i;
    }
    if (result != _draggingTabId) {
      return result;
    }
    //오른쪽 검사
    for (int i = result + 1; i < _tabItems.length; i++) {
      final RenderBox tabBox =
          _tabItems[i].key.currentContext!.findRenderObject() as RenderBox;
      final Offset tabPosition = tabBox.localToGlobal(Offset.zero);
      final Size tabSize = tabBox.size;
      final tabCenter = tabPosition.dx + tabSize.width / 2;
      if (tabCenter > right) {
        // print('tabCenter: $tabCenter, right: $right');
        break;
      }
      result = i;
    }
    return result;
  }

  Widget _buildTab(int index, bool isDragging, {bool isFeedBack = false}) {
    final int tabId = index;
    final int tabIndex = _currentTabIndex;
    return Opacity(
      key: isFeedBack ? null : _tabItems[tabId].key,
      opacity: _draggingTabId == tabId && !isDragging
          ? 0.5
          : (tabIndex == tabId ? 1 : 0.7),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          _mousePosition = details.globalPosition;
          final RenderBox tabBox = _tabItems[tabId]
              .key
              .currentContext!
              .findRenderObject() as RenderBox;
          final Offset tabPosition = tabBox.localToGlobal(Offset.zero);
          _feedBackOffset = details.globalPosition - tabPosition;
          _mouseStartPosition = details.globalPosition;
          _draggingTabId = tabId;
          _tabBarStateSetState!(() {});
        },
        // onHorizontalDragStart: (details) {},
        onPanEnd: (details) {
          _draggingTabId = -1;
          setState(() {});
        },
        onTap: () {
          animateToTab(tabId);
        },
        trackpadScrollCausesScale: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: tabIndex == tabId
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2), // 그림자 방향
                      ),
                    ],
                  )
                : null,
            child: Row(
              children: [
                Icon(_tabItems[tabId].icon),
                const SizedBox(width: 8.0),
                _tabItems[tabId].tabBar,
                const SizedBox(width: 8.0),
                IconButton(
                  iconSize: 15,
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                  onPressed: () async {
                    if (await _tabItems[tabId].onClose?.call() ?? true) {
                      removeTab(tabId);
                    }
                  },
                  padding: const EdgeInsets.all(3),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabBarView extends StatefulWidget implements PreferredSizeWidget {
  final TabConnector connector;
  const TabBarView({required this.connector, super.key});

  @override
  Size get preferredSize => Size.fromHeight(connector._height);

  @override
  State<TabBarView> createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.connector._tabBarStateSetState = setState;
  }

  @override
  void dispose() {
    widget.connector._tabBarStateSetState = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.connector.buildTabBarView();
  }
}

class TabContentView extends StatefulWidget {
  final TabConnector connector;
  const TabContentView({required this.connector, super.key});

  @override
  State<TabContentView> createState() => _TabContentViewState();
}

class _TabContentViewState extends State<TabContentView> {
  @override
  void initState() {
    super.initState();
    widget.connector._tabContentStateSetState = setState;
  }

  @override
  void dispose() {
    widget.connector._tabContentStateSetState = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.connector.buildTabContentView();
  }
}
