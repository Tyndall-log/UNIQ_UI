import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniq_ui/features/workspace/screen.dart';
import 'package:rive/rive.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]); // 가로 모드로 고정
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // 전체화면
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: WorkspaceScreen(),
        ),
      ),
    );
  }
}
