import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fnv/fnv.dart';
import 'package:uniq_ui/common/sample_toast.dart';
import 'package:jni/jni.dart';
import 'alias.dart';

part 'core/callback_manager.dart';
part 'core/id.dart';
part 'core/hash.dart';
part 'core/log.dart';
part 'workspace/workspace.dart';
part 'project/project.dart';
part 'unipack/unipack.dart';
part 'launchpad/launchpad.dart';

class UniqLibrary {
  static bool _isLoaded = false;
  static String _loadMessage = '';
  static DynamicLibrary? _uniqLibrary;

  static Future<void> load() async {
    if (_isLoaded) {
      print('UNIQ Library already loaded.');
      return;
    }
    _isLoaded = false;
    _uniqLibrary = null;
    final String path;

    if (Platform.isWindows) {
      path = 'UNIQ_Library.dll';
    } else if (Platform.isMacOS) {
      path = 'libUNIQ_Library.dylib';
    } else if (Platform.isLinux) {
      path = 'libUNIQ_Library.so';
    } else if (Platform.isAndroid) {
      path = 'libUNIQ_Library.so';
    } else if (Platform.isIOS) {
      // path = 'libUNIQ_Library.dylib';
      path = 'UNIQ_Library.framework/UNIQ_Library';
    } else {
      throw UnsupportedError('This platform is not supported.');
    }

    try {
      _uniqLibrary = DynamicLibrary.open(path);
    } catch (e) {
      // final String message = e.toString();
      // final List<String> messages = message.split(',');
      // for (var i = 0; i < messages.length; i++) {
      //   print('Error: ${messages[i]}');
      // }
      _loadMessage = 'UNIQ 라이브러리 파일을 찾을 수 없습니다.';
      _uniqLibrary = null;
      return;
    }

    try {
      final int Function(int a, int b) add = _uniqLibrary!.lookupFunction<
          Int32 Function(Int32 a, Int32 b),
          int Function(int a, int b)>('test1');
      final result = add(0xFFFFFFFF, 0x00000010);
      if (result != 0X0000000F) {
        _loadMessage = 'UNIQ 라이브러리를 로드하였으나, 함수 호출 테스트에 실패하였습니다.';
        return;
      }
    } catch (e) {
      _loadMessage = 'UNIQ 라이브러리를 로드하였으나, 함수 호출 테스트에 실패하였습니다.(예외)';
      return;
    }

    if (Platform.isAndroid) {
      final completer = Completer<void>();
      Future<void> _initApi() async {
        const platform = MethodChannel('com.uniq.ui/native');
        try {
          // 네이티브 메서드 'apiInit'를 호출합니다.
          final String result = await platform.invokeMethod('apiInit');
          print('Native method returned: $result');
        } on PlatformException catch (e) {
          print('Failed to call native method: ${e.message}');
          _loadMessage = 'UNIQ 라이브러리를 로드하였으나, 초기화에 실패하였습니다.';
        }
      }

      await _initApi();
    }

    _isLoaded = true;
    _loadMessage = 'UNIQ 라이브러리를 성공적으로 로드했습니다.';
    CallbackManager.init();
    Loger.startLogTimer();
  }

  static void _showFatalErrorToast(BuildContext context) {
    callback(v) {
      Future.delayed(const Duration(milliseconds: 500),
          () => _showFatalErrorToast(context));
    }

    SampleToast.show(
      context: context,
      title: '치명적인 오류: UNIQ 라이브러리 로드 실패',
      description: _loadMessage,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      applyBlurEffect: false,
      autoCloseDuration: const Duration(seconds: 0),
      callbacks: ToastificationCallbacks(
        onTap: callback,
        onDismissed: (v) => _showFatalErrorToast(context),
        onCloseButtonTap: (v) {
          Toastification().dismiss(v);
          callback(v);
        },
      ),
    );
  }

  static void loadCheck(BuildContext context) {
    if (_isLoaded) {
      SampleToast.show(
          context: context,
          title: 'UNIQ 라이브러리 로드 성공',
          description: _loadMessage,
          type: ToastificationType.success);
    } else {
      _showFatalErrorToast(context);
    }
  }

  static void unload() {
    if (!_isLoaded) {
      print('UNIQ Library already unloaded.');
      return;
    }
    _isLoaded = false;
    _uniqLibrary = null;
    _loadMessage = '';
    CallbackManager.stopCallbackTimer();
    Loger.stopLogTimer();
  }
}
