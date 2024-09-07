part of '../uniq.dart';

enum PreferredId {
  unknown,
  create,
  destroy,
  launchpadManager,
  last,
}

final class ApiCallbackMessage extends Struct {
  @Uint64()
  external int apiWorkspaceId;
  external Pointer<Utf8> apiFuncName;
  @Uint64()
  external int objId;
  external Pointer<Utf8> objIdTypeName;
  @Uint64()
  external int funcId;
  external Pointer<Utf8> funcIdName;
  @Uint64()
  external int dataSize;
  external Pointer<Void> dataPtr;

  @override
  String toString() {
    return 'ApiCallbackMessage{\n\t'
        'apiWorkspaceId: $apiWorkspaceId,\n\t'
        // 'apiFuncName: ${apiFuncName.toDartString()},\n\t'
        'objId: $objId,\n\t'
        'objIdTypeName: ${objIdTypeName.toDartString()},\n\t'
        'funcId: $funcId,\n\t'
        'funcIdName: ${funcIdName.toDartString()},\n\t'
        'dataSize: $dataSize,\n\t'
        'dataPtr: $dataPtr\n}';
  }
}

final class LaunchpadManagerConnectData extends Struct {
  @Uint64()
  external int id;
  @Bool()
  external bool connectFlag;
  external Pointer<Utf8> inputName;
  external Pointer<Utf8> inputKindName;
  external Pointer<Utf8> inputIdentifier;
  external Pointer<Utf8> outputName;
  external Pointer<Utf8> outputKindName;
  external Pointer<Utf8> outputIdentifier;
}

typedef _GetApiCallbackMessage = Pointer<ApiCallbackMessage> Function();
typedef _ReleaseApiCallbackMessageC = Void Function(
    Pointer<ApiCallbackMessage>);
typedef _ReleaseApiCallbackMessage = void Function(Pointer<ApiCallbackMessage>);

extension CallbackManager on UniqLibrary {
  static final Map<int, Function(ApiCallbackMessage)> _callbackWorkspaceIdMap =
      {};
  static final Map<int, Function(ApiCallbackMessage)> _callbackIdMap = {};
  static Timer? _callbackTimer;

  static final _GetApiCallbackMessage _getMessage = UniqLibrary._uniqLibrary!
      .lookupFunction<_GetApiCallbackMessage, _GetApiCallbackMessage>(
          'API_callback_message_get');
  static final _ReleaseApiCallbackMessage _releaseMessage = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<_ReleaseApiCallbackMessageC, _ReleaseApiCallbackMessage>(
          'API_callback_message_release');

  static void registerWorkspaceCallback(
      int apiWorkspaceId, Function(ApiCallbackMessage) callback) {
    _callbackWorkspaceIdMap[apiWorkspaceId] = callback;
  }

  static void registerCallbackById(
      int objId, Function(ApiCallbackMessage) callback) {
    _callbackIdMap[objId] = callback;
  }

  static void registerCallbackByName(
      String funcName, Function(ApiCallbackMessage) callback) {
    final objId = Hash.fnv1aHash(funcName);
    _callbackIdMap[objId] = callback;
  }

  static void unregisterWorkspaceCallback(int apiWorkspaceId) {
    _callbackWorkspaceIdMap.remove(apiWorkspaceId);
  }

  static void unregisterCallbackById(int objId) {
    _callbackIdMap.remove(objId);
  }

  static void unregisterCallbackByName(String funcName) {
    final objId = Hash.fnv1aHash(funcName);
    _callbackIdMap.remove(objId);
  }

  static int count = 0;
  static void startCallbackTimer() {
    if (_callbackTimer != null) {
      return;
    }
    _callbackTimer = Timer.periodic(const Duration(milliseconds: 8), (timer) {
      var timeLimit = const Duration(milliseconds: 4);
      final stopwatch = Stopwatch()..start();
      do {
        final Pointer<ApiCallbackMessage> messagePtr = _getMessage();
        if (messagePtr == nullptr) return;
        final message = messagePtr.ref;
        // if (message.objId < PreferredId.last.index) {
        //   final callback = _callbackWorkspaceIdMap[message.apiWorkspaceId];
        //   if (callback != null) {
        //     callback(message);
        //   } else {
        //     count++;
        //     print('Callback not found: $count');
        //   }
        // } else {
        //
        // }
        final callback = _callbackIdMap[message.objId];
        if (callback != null) {
          callback(message);
        } else {
          count++;
          if (count % 100 == 0) print('누적 $count 개의 콜벡을 처리하지 않아 무시합니다.');
        }
        _releaseMessage(messagePtr);
      } while (stopwatch.elapsed < timeLimit);
      stopwatch.stop();
    });
  }

  static void stopCallbackTimer() {
    _callbackTimer?.cancel();
    _callbackTimer = null;
  }
}
