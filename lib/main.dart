import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniq_ui/features/workspace/screen.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';
import 'package:uniq_ui/common/sample_toast.dart';
import 'package:uniq_ui/features/tab_view/tabs/start_page.dart';
import 'package:uniq_ui/features/tab_view/tabs/workspace.dart';
import 'package:uniq_ui/features/tab_view/tab_bar.dart' as TabBar;
// import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]); // 가로 모드로 고정
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // 전체화면
  //시간 측정
  Stopwatch stopwatch = Stopwatch()..start();
  await UniqLibrary.load();
  print('UNIQ Library load time: ${stopwatch.elapsedMilliseconds}ms');
  // CallbackManager.registerCallback('test', (String message) {
  //   print('Callback: $message');
  // });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('build MyApp');

    return MaterialApp(
      home: BlocProvider(
        create: (context) => TabBar.TabBloc(
          context: context,
          tabItems: [
            StartPageTab(),
            // WorkspaceTab(workspaceId: 999999),
          ],
          tabAddCallback: (TabBar.TabBloc tabBloc) {
            tabBloc.add(TabBar.AddTab(
              tabItem: StartPageTab(),
            ));
          },
        ),
        child: Scaffold(
          // appBar: AppBar(
          //   toolbarHeight: 0,
          //   elevation: 0,
          //   bottom: const TabBar.TabBarView(),
          //   backgroundColor: Colors.transparent,
          // ),
          body: Stack(
            children: [
              _AppInit(child: TabBar.TabContentView()),
              const TabBar.TabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppInit extends StatefulWidget {
  final Widget child;
  const _AppInit({super.key, required this.child});

  @override
  State<_AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<_AppInit> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UniqLibrary.loadCheck(context);
    });
    CallbackManager.registerCallback(
      preferredId: PreferredId.create,
      funcIdName: 'uniq::workspace::workspace',
      callback: (message) {
        var data = message.dataPtr.cast<IdLifecycle>().ref;
        var re = context.read<TabBar.TabBloc>();
        re.add(
          TabBar.ReplaceTab(
            index: re.state.currentIndex,
            tabItem: WorkspaceTab(workspaceId: data.id),
          ),
        );
        CallbackManager.registerCallback(
          workspaceId: data.id,
          preferredId: PreferredId.destroy,
          funcIdName: 'uniq::workspace::workspace',
          callback: (message) {
            var data = message.dataPtr.cast<IdLifecycle>().ref;
            var re = context.read<TabBar.TabBloc>();
            re.add(
              TabBar.RemoveTabByTabItem(
                tabItem: re.state.tabItems.firstWhere(
                  // (element) => (element as WorkspaceTab).workspaceId == data.id),
                  (element) {
                    if (element is WorkspaceTab) {
                      return element.workspaceId == data.id;
                    }
                    return false;
                  },
                ),
              ),
            );
          },
        );
      },
    );
    CallbackManager.registerCallback(
      preferredId: PreferredId.launchpadManager,
      funcIdName: "static void uniq::launchpad::launchpad_manager::"
          "RAC(const std::shared_ptr<launchpad> &, bool)",
      callback: (ApiCallbackMessage message) {
        final LaunchpadManagerConnectData data =
            message.dataPtr.cast<LaunchpadManagerConnectData>().ref;
        if (data.connectFlag) Launchpad.programModeSet(data.id, true);
        SampleToast.show(
          title: data.inputKindName.toDartString() +
              (data.connectFlag ? ' 연결됨' : ' 해제됨'),
          context: context,
          description: "inputID: ${data.inputIdentifier.toDartString()}\n"
              "outputID: ${data.outputIdentifier.toDartString()}",
          type: ToastificationType.info,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
