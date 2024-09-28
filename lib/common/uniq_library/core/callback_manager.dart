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

final class IdLifecycle extends Struct {
  @Uint64()
  external int id;
}

class CallbackKey {
  final int workspaceId; // apiWorkspaceId (not hash)
  final int objId; // PreferredId or objId (not hash)
  final int funcId; // funcId (fnv1aHash of funcName)

  CallbackKey(this.workspaceId, this.objId, this.funcId);

  @override
  bool operator ==(Object other) {
    if (other is CallbackKey) {
      return workspaceId == other.workspaceId &&
          objId == other.objId &&
          funcId == other.funcId;
    }
    return false;
  }

  @override
  int get hashCode => workspaceId ^ (objId << 32 | objId >> 32) ^ funcId;
}

typedef ApiCallback = void Function(ApiCallbackMessage);
typedef _GetApiCallbackMessage = Pointer<ApiCallbackMessage> Function();
typedef _ReleaseApiCallbackMessageC = Void Function(
    Pointer<ApiCallbackMessage>);
typedef _ReleaseApiCallbackMessage = void Function(Pointer<ApiCallbackMessage>);

extension CallbackManager on UniqLibrary {
  static final Map<CallbackKey, ApiCallback> _callbackKeyMap = {};
  static final Map<int, Set<CallbackKey>> _callbackWorkspaceIdKeyMap = {};
  static final Map<int, Set<CallbackKey>> _callbackObjIdKeyMap = {};
  // static final Map<int, void Function(ApiCallbackMessage)> _callbackWorkspaceIdMap =
  //     {};
  // static final Map<int, void Function(ApiCallbackMessage)> _callbackIdMap = {};
  // static final Map<PreferredId, Map<int, void Function(ApiCallbackMessage)>>
  //     _callbackPreferredIdMap = {};
  static Timer? _callbackTimer;

  static final _GetApiCallbackMessage _getMessage = UniqLibrary._uniqLibrary!
      .lookupFunction<_GetApiCallbackMessage, _GetApiCallbackMessage>(
          'API_callback_message_get');
  static final _ReleaseApiCallbackMessage _releaseMessage = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<_ReleaseApiCallbackMessageC, _ReleaseApiCallbackMessage>(
          'API_callback_message_release');

  static void init() {
    startCallbackTimer();
  }

  static void registerCallback({
    int? workspaceId,
    int? objId,
    PreferredId? preferredId,
    int? funcId,
    String? funcIdName,
    required ApiCallback callback,
  }) {
    assert(objId != null || preferredId != null);
    assert(funcId != null || funcIdName != null);

    workspaceId ??= 0;
    objId ??= preferredId!.index;
    funcId ??= Hash.fnv1aHash(funcIdName!);

    final key = CallbackKey(workspaceId, objId, funcId);
    _callbackKeyMap[key] = callback;
    (_callbackWorkspaceIdKeyMap[workspaceId] ??= {}).add(key);
    (_callbackObjIdKeyMap[objId] ??= {}).add(key);
  }

  // static void registerWorkspaceCallback(
  //     int apiWorkspaceId, Function(ApiCallbackMessage) callback) {
  //   _callbackWorkspaceIdMap[apiWorkspaceId] = callback;
  // }

  // static void registerCallbackById(
  //     int objId, Function(ApiCallbackMessage) callback) {
  //   _callbackIdMap[objId] = callback;
  // }
  //
  // static void registerCallbackByName(
  //     String funcName, Function(ApiCallbackMessage) callback) {
  //   final objId = Hash.fnv1aHash(funcName);
  //   _callbackIdMap[objId] = callback;
  // }
  //
  // static void registerCallbackByPreferredId(PreferredId preferredId, int funcId,
  //     Function(ApiCallbackMessage) callback) {
  //   if (!_callbackPreferredIdMap.containsKey(preferredId)) {
  //     _callbackPreferredIdMap[preferredId] = {};
  //   }
  //   _callbackPreferredIdMap[preferredId]![funcId] = callback;
  // }
  //
  // static void registerCallbackByPreferredIdFuncName(PreferredId preferredId,
  //     String funcName, Function(ApiCallbackMessage) callback) {
  //   final objId = Hash.fnv1aHash(funcName);
  //   registerCallbackByPreferredId(preferredId, objId, callback);
  // }

  static void unregisterCallback({
    int? workspaceId,
    int? objId,
    PreferredId? preferredId,
    int? funcId,
    String? funcName,
  }) {
    assert(objId != null || preferredId != null);
    assert(funcId != null || funcName != null);

    workspaceId ??= 0;
    objId ??= preferredId!.index;
    funcId ??= Hash.fnv1aHash(funcName!);

    final key = CallbackKey(workspaceId, objId, funcId);
    _callbackKeyMap.remove(key);
    final workspaceIdKeyList = _callbackWorkspaceIdKeyMap[workspaceId]!;
    if (workspaceIdKeyList.remove(key) && workspaceIdKeyList.isEmpty) {
      _callbackWorkspaceIdKeyMap.remove(workspaceId);
    }
    final objIdKeyList = _callbackObjIdKeyMap[objId]!;
    if (objIdKeyList.remove(key) && objIdKeyList.isEmpty) {
      _callbackObjIdKeyMap.remove(objId);
    }
  }

  static void unregisterCallbackByWorkspaceIdAll(int workspaceId) {
    for (var key in _callbackWorkspaceIdKeyMap[workspaceId] ?? {}) {
      _callbackKeyMap.remove(key);
      final objIdKeyList = _callbackObjIdKeyMap[key.objId]!;
      if (objIdKeyList.remove(key) && objIdKeyList.isEmpty) {
        _callbackObjIdKeyMap.remove(key.objId);
      }
    }
    _callbackWorkspaceIdKeyMap.remove(workspaceId);
  }

  static void unregisterCallbackByObjIdAll(int objId) {
    for (var key in _callbackObjIdKeyMap[objId] ?? {}) {
      _callbackKeyMap.remove(key);
      final workspaceIdKeyList = _callbackWorkspaceIdKeyMap[key.workspaceId]!;
      if (workspaceIdKeyList.remove(key) && workspaceIdKeyList.isEmpty) {
        _callbackWorkspaceIdKeyMap.remove(key.workspaceId);
      }
    }
    _callbackObjIdKeyMap.remove(objId);
  }

  static void unregisterCallbackByPreferredIdAll(PreferredId preferredId) {
    unregisterCallbackByObjIdAll(preferredId.index);
  }

  // static void unregisterWorkspaceCallback(int apiWorkspaceId) {
  //   _callbackWorkspaceIdMap.remove(apiWorkspaceId);
  // }

  // static void unregisterCallbackById(int objId) {
  //   _callbackIdMap.remove(objId);
  // }
  //
  // static void unregisterCallbackByName(String funcName) {
  //   final objId = Hash.fnv1aHash(funcName);
  //   _callbackIdMap.remove(objId);
  // }
  //
  // static void unregisterCallbackByPreferredId(
  //     PreferredId preferredId, int funcId) {
  //   if (!_callbackPreferredIdMap.containsKey(preferredId)) {
  //     return;
  //   }
  //   _callbackPreferredIdMap[preferredId]!.remove(funcId);
  //   if (_callbackPreferredIdMap[preferredId]!.isEmpty) {
  //     _callbackPreferredIdMap.remove(preferredId);
  //   }
  // }

  static int count = 0;
  static int lastCount = 0;
  static void startCallbackTimer() {
    if (_callbackTimer != null) {
      return;
    }
    _callbackTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      var timeLimit = const Duration(milliseconds: 4);
      final stopwatch = Stopwatch()..start();
      do {
        final Pointer<ApiCallbackMessage> messagePtr = _getMessage();
        if (messagePtr == nullptr) break;
        final message = messagePtr.ref;
        final callback = _callbackKeyMap[
            CallbackKey(message.apiWorkspaceId, message.objId, message.funcId)];
        if (callback != null) {
          callback(message);
        } else {
          Loger.printLog('콜백을 찾을 수 없습니다: $message');
          count++;
        }
        _releaseMessage(messagePtr);
      } while (stopwatch.elapsed < timeLimit);
      stopwatch.stop();
      if (count != lastCount) {
        print('누적 $count 개의 콜벡을 처리하지 않아 무시되었습니다.');
        print('현재 등록된 콜백: ${_callbackKeyMap.length}개');
        lastCount = count;
      }
    });
  }

  static void stopCallbackTimer() {
    _callbackTimer?.cancel();
    _callbackTimer = null;
  }
}
