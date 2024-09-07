import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'event.dart';
import 'state.dart';
import '../model/tab_item.dart';

export '../model/tab_item.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  final BuildContext _context;
  final OverlayState _overlayState;
  final PageController _pageController = PageController();
  int _draggingTabId = -1;
  Offset _mousePosition = Offset.zero;
  Offset _feedBackOffset = Offset.zero;
  Offset _mouseStartPosition = Offset.zero;
  bool needRebuild = false;
  double _height = kToolbarHeight;
  GlobalKey _listViewKey = GlobalKey();
  Function(TabBloc)? _tabAddCallback;

  bool _draggingOnceFlag = false;

  PageController get pageController => _pageController;
  // @override
  // void onEvent(TabEvent event) {
  //   super.onEvent(event);
  //   // 여기서 이벤트가 add 된 시점을 감지할 수 있습니다.
  //   print('Event added: $event');
  // }

  OverlayState get overlayState => _overlayState;

  TabBloc(
      {required BuildContext context,
      required List<TabItem> tabItems,
      Function(TabBloc)? tabAddCallback})
      : _context = context,
        _overlayState = Overlay.of(context),
        _height = kToolbarHeight,
        _tabAddCallback = tabAddCallback,
        super(TabState(tabItems: tabItems, currentIndex: 0, targetIndex: 0)) {
    on<AddTab>((event, emit) {
      final updatedTabItems = List<TabItem>.from(state.tabItems)
        ..add(event.tabItem);
      emit(state.copyWith(
        tabItems: updatedTabItems,
        tabBarRebuildFlag: true,
        tabContentRebuildFlag: true,
      ));
    });

    on<ReplaceTab>((event, emit) {
      final updatedTabItems = List<TabItem>.from(state.tabItems)
        ..[event.index] = event.tabItem;
      emit(state.copyWith(
        tabItems: updatedTabItems,
        tabBarRebuildFlag: true,
        tabContentRebuildFlag: true,
      ));
    });

    on<RemoveTab>((event, emit) {
      // if (state.tabItems.length <= 1) return;

      final updatedTabItems = List<TabItem>.from(state.tabItems)
        ..removeAt(event.index);

      final newIndex = min(
        event.index < state.targetIndex
            ? state.targetIndex - 1
            : state.targetIndex,
        updatedTabItems.length - 1,
      );
      _pageController.jumpToPage(newIndex);
      // animateToTab(newIndex);

      emit(state.copyWith(
        tabItems: updatedTabItems,
        targetIndex: newIndex,
        tabBarRebuildFlag: true,
        tabContentRebuildFlag: true,
      ));
    });

    int updateIndex(int oldIndex, int newIndex, int currentIndex) {
      if (currentIndex == oldIndex) {
        return newIndex;
      } else if (oldIndex < currentIndex && currentIndex <= newIndex) {
        return currentIndex - 1;
      } else if (newIndex <= currentIndex && currentIndex < oldIndex) {
        return currentIndex + 1;
      }
      return currentIndex;
    }

    on<MoveTab>((event, emit) {
      final updatedTabItems = List<TabItem>.from(state.tabItems);
      int oldIndex = event.oldIndex;
      int newIndex = event.newIndex;
      assert(oldIndex != newIndex);
      final item = updatedTabItems.removeAt(oldIndex);
      updatedTabItems.insert(newIndex, item);

      int newCurrentIndex = updateIndex(oldIndex, newIndex, state.currentIndex);
      int newTargetIndex = updateIndex(oldIndex, newIndex, state.targetIndex);

      if (newCurrentIndex == newTargetIndex) {
        _pageController.jumpToPage(newTargetIndex);
      } else {
        animateToTab(newTargetIndex);
      }

      _draggingTabId = newIndex;

      emit(state.copyWith(
        tabItems: updatedTabItems,
        currentIndex: newCurrentIndex,
        targetIndex: newTargetIndex,
        tabBarRebuildFlag: true,
        tabContentRebuildFlag: true,
      ));
    });

    on<AnimateToTab>((event, emit) {
      animateToTab(event.index);
      emit(state.copyWith(
        targetIndex: event.index,
        tabBarRebuildFlag: true,
      ));
    });

    on<DragTab>((event, emit) {
      emit(state.copyWith(
        dragPosition: event.position,
        tabBarRebuildFlag: true,
      ));
    });

    on<ChangeCurrentIndex>((event, emit) {
      emit(state.copyWith(
        currentIndex: event.index,
        tabBarRebuildFlag: true,
      ));
    });

    on<ChangeTargetIndex>((event, emit) {
      emit(state.copyWith(
        targetIndex: event.index,
        tabBarRebuildFlag: true,
      ));
    });

    on<TabBarNeedRebuild>((event, emit) {
      if (state.tabBarRebuildFlag) return;
      emit(state.copyWith(tabBarRebuildFlag: true));
    });

    on<TabContentCompletedRebuild>((event, emit) {
      if (!state.tabContentRebuildFlag) return;
      emit(state.copyWith(tabContentRebuildFlag: false));
    });

    on<TabContentNeedRebuild>((event, emit) {
      if (state.tabContentRebuildFlag) return;
      emit(state.copyWith(tabContentRebuildFlag: true));
    });

    on<TabBarCompletedRebuild>((event, emit) {
      if (!state.tabBarRebuildFlag) return;
      emit(state.copyWith(tabBarRebuildFlag: false));
    });

    on<ClearTabs>((event, emit) {
      emit(state.copyWith(
        tabItems: [],
        currentIndex: 0,
        targetIndex: 0,
        tabBarRebuildFlag: true,
        tabContentRebuildFlag: true,
      ));
    });
  }

  void animateToTab(int index) {
    final duration =
        (log((index - state.currentIndex).abs() + 4) * 150).toInt();
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOutCubic,
    );
    add(ChangeTargetIndex(index: index));
  }

  int _getTabBarIndex(Offset offset) {
    final List<TabItem> _tabItems = state.tabItems;
    final RenderBox nowTabBox = _tabItems[_draggingTabId]
        .tabBarKey
        .currentContext!
        .findRenderObject() as RenderBox;
    const double threshold = 10;
    final left = offset.dx - _feedBackOffset.dx + threshold;
    final right = left + nowTabBox.size.width - threshold;
    var result = _draggingTabId;
    //왼쪽 검사
    for (int i = result - 1; i >= 0; i--) {
      final RenderBox tabBox = _tabItems[i]
          .tabBarKey
          .currentContext!
          .findRenderObject() as RenderBox;
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
      final RenderBox tabBox = _tabItems[i]
          .tabBarKey
          .currentContext!
          .findRenderObject() as RenderBox;
      final Offset tabPosition = tabBox.localToGlobal(Offset.zero);
      final Size tabSize = tabBox.size;
      final tabCenter = tabPosition.dx + tabSize.width / 2;
      if (tabCenter > right) {
        break;
      }
      result = i;
    }
    return result;
  }

  Widget buildTab(int index, bool isDragging, {bool isFeedBack = false}) {
    final int tabId = index;
    final int tabIndex = state.currentIndex;
    final List<TabItem> _tabItems = state.tabItems;
    return Opacity(
      key: isFeedBack ? null : _tabItems[tabId].tabBarKey,
      opacity: _draggingTabId == tabId && !isDragging
          ? 0.5
          : (tabIndex == tabId ? 1 : 0.7),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          _mousePosition = details.globalPosition;
          final RenderBox tabBox = _tabItems[tabId]
              .tabBarKey
              .currentContext!
              .findRenderObject() as RenderBox;
          final Offset tabPosition = tabBox.localToGlobal(Offset.zero);
          _feedBackOffset = details.globalPosition - tabPosition;
          _mouseStartPosition = details.globalPosition;
          _draggingTabId = tabId;
          add(TabBarNeedRebuild());
        },
        // onHorizontalDragStart: (details) {},
        onPanEnd: (details) {
          _draggingTabId = -1;
          // setState(() {});
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
                    if (await _tabItems[tabId].onClose?.call(this) ?? true) {
                      add(RemoveTab(index: tabId));
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

  Widget buildTabBarView() {
    needRebuild = false;
    return BlocBuilder<TabBloc, TabState>(
      buildWhen: (previous, current) {
        return current.tabBarRebuildFlag;
      },
      builder: (context, state) {
        _draggingOnceFlag = false;
        var _tabItems = state.tabItems;
        add(TabBarCompletedRebuild());
        return Listener(
          onPointerDown: (event) {
            _draggingOnceFlag = false;
            // add(TabBarNeedRebuild());
            // _tabBarStateSetState!(() {});
          },
          onPointerMove: (event) {
            _mousePosition = event.position;
            if (_draggingOnceFlag) return;
            _draggingOnceFlag = true;
            if (_draggingTabId == -1) return;
            add(DragTab(position: event.position));
            final RenderBox listBox =
                _listViewKey.currentContext!.findRenderObject() as RenderBox;
            final Offset localOffset = listBox.globalToLocal(_mousePosition);
            int newIndex = _getTabBarIndex(localOffset);
            if (newIndex == _draggingTabId) return;
            add(MoveTab(oldIndex: _draggingTabId, newIndex: newIndex));
          },
          onPointerUp: (event) {
            _draggingTabId = -1;
            add(TabBarNeedRebuild());
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
                        child: buildTab(index, false),
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
                              _tabAddCallback!(this);
                              // _tabBarStateSetState!(() {});
                              // _tabContentStateSetState!(() {});
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
                      child: buildTab(_draggingTabId, true, isFeedBack: true),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTabContentView() {
    return BlocBuilder<TabBloc, TabState>(
      buildWhen: (previous, current) => current.tabContentRebuildFlag,
      builder: (context, state) {
        add(TabContentCompletedRebuild());
        var _tabItems = state.tabItems;
        return PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          onPageChanged: (index) {
            add(ChangeCurrentIndex(index: index));
          },
          children: [
            for (var item in _tabItems) //item.tabContent,
              KeepTab(
                key: item.tabContentKey,
                tabContent: item.tabContent,
              )
          ],
        );
      },
    );
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}

class KeepTab extends StatefulWidget {
  final Widget tabContent;

  const KeepTab({super.key, required this.tabContent});

  @override
  _KeepTabState createState() => _KeepTabState();
}

class _KeepTabState extends State<KeepTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.tabContent;
  }
}
