part of '../uniq.dart';

extension Project on UniqLibrary {
  // ==================== Project Start ====================
  // title_get
  static final Pointer<Utf8> Function(int) _titleGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Pointer<Utf8> Function(Uint64),
          Pointer<Utf8> Function(int)>('title_get');
  static String titleGet(int projectId) {
    final Pointer<Utf8> titlePtr = _titleGet(projectId);
    final String result = titlePtr.toDartString();
    malloc.free(titlePtr);
    return result;
  }

  // title_set
  static final void Function(int, Pointer<Utf8>) _titleSet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Pointer<Utf8>),
          void Function(int, Pointer<Utf8>)>('title_set');
  static void titleSet(int projectId, String title) {
    final Pointer<Utf8> titlePtr = title.toNativeUtf8();
    _titleSet(projectId, titlePtr);
    malloc.free(titlePtr);
  }

  // producer_name_get
  static final Pointer<Utf8> Function(int) _producerNameGet =
      UniqLibrary._uniqLibrary!.lookupFunction<Pointer<Utf8> Function(Uint64),
          Pointer<Utf8> Function(int)>('producer_name_get');
  static String producerNameGet(int projectId) {
    final Pointer<Utf8> producerNamePtr = _producerNameGet(projectId);
    final String result = producerNamePtr.toDartString();
    malloc.free(producerNamePtr);
    return result;
  }

  // producer_name_set
  static final void Function(int, Pointer<Utf8>) _producerNameSet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Pointer<Utf8>),
          void Function(int, Pointer<Utf8>)>('producer_name_set');
  static void producerNameSet(int projectId, String producerName) {
    final Pointer<Utf8> producerNamePtr = producerName.toNativeUtf8();
    _producerNameSet(projectId, producerNamePtr);
    malloc.free(producerNamePtr);
  }

  // audio_load
  static final int Function(int, Pointer<Utf8>) _audioLoad =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Uint64 Function(Uint64, Pointer<Utf8>),
          int Function(int, Pointer<Utf8>)>('audio_load');
  static int audioLoad(int projectId, String path) {
    final Pointer<Utf8> pathPtr = path.toNativeUtf8();
    final int result = _audioLoad(projectId, pathPtr);
    malloc.free(pathPtr);
    return result;
  }

  // audio_source_add
  static final void Function(int, int) _audioSourceAdd = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Uint64), void Function(int, int)>(
          'audio_source_add');
  static void audioSourceAdd(int projectId, int audioSourceId) {
    _audioSourceAdd(projectId, audioSourceId);
  }

  // timeline_create
  static final int Function(int, Pointer<Utf8>) _timelineCreate =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Uint64 Function(Uint64, Pointer<Utf8>),
          int Function(int, Pointer<Utf8>)>('timeline_create');
  static int timelineCreate(int projectId, String name) {
    final Pointer<Utf8> namePtr = name.toNativeUtf8();
    final int result = _timelineCreate(projectId, namePtr);
    malloc.free(namePtr);
    return result;
  }

  // timeline_get
  static final int Function(int, Pointer<Utf8>) _timelineGet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Uint64 Function(Uint64, Pointer<Utf8>),
          int Function(int, Pointer<Utf8>)>('timeline_get');
  static int timelineGet(int projectId, String name) {
    final Pointer<Utf8> namePtr = name.toNativeUtf8();
    final int result = _timelineGet(projectId, namePtr);
    malloc.free(namePtr);
    return result;
  }

  // timeline_remove
  static final bool Function(int, Pointer<Utf8>) _timelineRemove =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Bool Function(Uint64, Pointer<Utf8>),
          bool Function(int, Pointer<Utf8>)>('timeline_remove');
  static bool timelineRemove(int projectId, String name) {
    final Pointer<Utf8> namePtr = name.toNativeUtf8();
    final bool result = _timelineRemove(projectId, namePtr);
    malloc.free(namePtr);
    return result;
  }

  // timeline_page_add
  static final bool Function(int, int) _timelinePageAdd = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64, Uint64), bool Function(int, int)>(
          'timeline_page_add');
  static bool timelinePageAdd(int projectId, int pageId) {
    return _timelinePageAdd(projectId, pageId);
  }

  // timeline_page_create
  static final int Function(int, int) _timelinePageCreate = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Uint64 Function(Uint64, Int64), int Function(int, int)>(
          'timeline_page_create');
  static int timelinePageCreate(int projectId, int cue) {
    return _timelinePageCreate(projectId, cue);
  }

  // timeline_page_find_floor
  static final int Function(int, int) _timelinePageFindFloor = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Uint64 Function(Uint64, Int64), int Function(int, int)>(
          'timeline_page_find_floor');
  static int timelinePageFindFloor(int projectId, int cue) {
    return _timelinePageFindFloor(projectId, cue);
  }

  // timeline_page_remove
  static final bool Function(int, int) _timelinePageRemove = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64, Uint64), bool Function(int, int)>(
          'timeline_page_remove');
  static bool timelinePageRemove(int projectId, int pageId) {
    return _timelinePageRemove(projectId, pageId);
  }

  // guide_start
  static final void Function(int, int) _guideStart = UniqLibrary._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Int64), void Function(int, int)>(
          'guide_start');
  static void guideStart(int projectId, int cue) {
    _guideStart(projectId, cue);
  }

  // guide_resume
  static final void Function(int, int) _guideResume = UniqLibrary._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Int64), void Function(int, int)>(
          'guide_resume');
  static void guideResume(int projectId, int cue) {
    _guideResume(projectId, cue);
  }

  // guide_position_set
  static final void Function(int, int) _guidePositionSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Int64), void Function(int, int)>(
          'guide_position_set');
  static void guidePositionSet(int projectId, int cue) {
    _guidePositionSet(projectId, cue);
  }

  // guide_position_get
  static final int Function(int) _guidePositionGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Int64 Function(Uint64), int Function(int)>(
          'guide_position_get');
  static int guidePositionGet(int projectId) {
    return _guidePositionGet(projectId);
  }

  // guide_pause
  static final void Function(int) _guidePause = UniqLibrary._uniqLibrary!
      .lookupFunction<Void Function(Uint64), void Function(int)>('guide_pause');
  static void guidePause(int projectId) {
    _guidePause(projectId);
  }

  // guide_stop
  static final void Function(int) _guideStop = UniqLibrary._uniqLibrary!
      .lookupFunction<Void Function(Uint64), void Function(int)>('guide_stop');
  static void guideStop(int projectId) {
    _guideStop(projectId);
  }

  // launchpad_connect
  static final bool Function(int, int) _launchpadConnect = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64, Uint64), bool Function(int, int)>(
          'launchpad_connect');
  static bool launchpadConnect(int projectId, int launchpadId) {
    return _launchpadConnect(projectId, launchpadId);
  }

  // launchpad_auto_connect
  static final bool Function(int) _launchpadAutoConnect = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64), bool Function(int)>(
          'launchpad_auto_connect');
  static bool launchpadAutoConnect(int projectId) {
    return _launchpadAutoConnect(projectId);
  }

  // launchpad_disconnect_all
  static final bool Function(int) _launchpadDisconnectAll = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64), bool Function(int)>(
          'launchpad_disconnect_all');
  static bool launchpadDisconnectAll(int projectId) {
    return _launchpadDisconnectAll(projectId);
  }

  // pad_button_down
  static final void Function(int, int, int, int) _padButtonDown =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Uint8, Uint8, Uint8),
          void Function(int, int, int, int)>('pad_button_down');
  static void padButtonDown(int projectId, int x, int y, int velocity) {
    _padButtonDown(projectId, x, y, velocity);
  }

  // pad_button_up
  static final void Function(int, int, int) _padButtonUp =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Uint8, Uint8),
          void Function(int, int, int)>('pad_button_up');
  static void padButtonUp(int projectId, int x, int y) {
    _padButtonUp(projectId, x, y);
  }

  // pad_button_touch
  static final void Function(int, int, int, int) _padButtonTouch =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Uint8, Uint8, Uint8),
          void Function(int, int, int, int)>('pad_button_touch');
  static void padButtonTouch(int projectId, int x, int y, int velocity) {
    _padButtonTouch(projectId, x, y, velocity);
  }
// ==================== Project End ====================
}
