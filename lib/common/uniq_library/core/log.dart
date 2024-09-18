part of '../uniq.dart';

typedef _LogC = Pointer<Utf8> Function();
typedef _Log = Pointer<Utf8> Function();

extension Loger on UniqLibrary {
  static Timer? _logTimer;
  static final List<Function> _logCallbackList = <Function>[];
  static final _Log _log =
      UniqLibrary._uniqLibrary!.lookupFunction<_LogC, _Log>('log_get');

  static void addLogCallback(Function callback) {
    _logCallbackList.add(callback);
  }

  static void removeLogCallback(Function callback) {
    _logCallbackList.remove(callback);
  }

  static void startLogTimer() {
    if (_logTimer != null) {
      return;
    }
    _logTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final Pointer<Utf8> logPtr = _log();
      if (logPtr == nullptr) {
        return;
      }
      var str = logPtr.toDartString();
      if (str.isEmpty) return;
      if (Platform.isIOS) {
        print(str);
      }
      for (var callback in _logCallbackList) {
        callback(str);
      }
    });
  }

  static void stopLogTimer() {
    if (_logTimer == null) {
      return;
    }
    _logTimer!.cancel();
    _logTimer = null;
  }
}
