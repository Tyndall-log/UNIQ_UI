import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uniq_ui/features/tab_view/tab_bar.dart';
import 'package:uniq_ui/features/tab_view/tabs/workspace.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String _version = '?.?.?';
  double leftMenuButtonSpacing = 16;
  double leftMenuButtonRunSpacing = 16;
  double leftMenuButtonWidth = 150;
  double leftMenuButtonPadding = 8;

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      _version = packageInfo.version;
      setState(() {});
    }
  }

  Widget leftButton(String text, {void Function()? onPressed}) {
    return Container(
      height: leftMenuButtonWidth,
      width: leftMenuButtonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // 둥근 모서리
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'UNIQ UI',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(width: 8),
              Text(
                'v$_version',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 전체 화면의 너비
                double maxWidth = constraints.maxWidth;

                // 왼쪽 메뉴의 고정된 너비 설정
                double leftMenuWidth = maxWidth * 0.4;

                int buttonCount = leftMenuWidth ~/ leftMenuButtonWidth;
                leftMenuWidth -= leftMenuWidth % leftMenuButtonWidth;
                leftMenuWidth += leftMenuButtonPadding * 2;
                leftMenuWidth += leftMenuButtonSpacing * (buttonCount - 1);

                return Row(
                  children: [
                    // 왼쪽 고정된 크기의 "빠른 메뉴 목록"
                    SizedBox(
                      width: leftMenuWidth,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '빠른 메뉴 목록',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(leftMenuButtonPadding),
                              child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: leftMenuButtonSpacing,
                                  runSpacing: leftMenuButtonRunSpacing,
                                  children: [
                                    leftButton(
                                      '새로운\n작업공간\n생성',
                                      onPressed: () async {
                                        Workspace.create();
                                      },
                                    ),
                                    leftButton(
                                      '라이브러리 불러오기',
                                      onPressed: () async {
                                        UniqLibrary.load();
                                      },
                                    ),
                                    leftButton(
                                      '라이브러리 끄기',
                                      onPressed: () async {
                                        UniqLibrary.unload();
                                      },
                                    ),
                                    for (int i = 0; i < 10; i++)
                                      leftButton('메뉴 $i'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '최근 프로젝트 목록',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                for (int i = 0; i < 10; i++)
                                  ListTile(
                                    title: Text('프로젝트 $i'),
                                    subtitle: Text('프로젝트 $i 설명'),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
