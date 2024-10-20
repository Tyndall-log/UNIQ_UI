part of '../uniq.dart';

extension TimelineGroup on UniqLibrary {
  // ==================== TimelineGroup Start ====================
  // API int8_t group_button_x_get(id_t group_id);
  // group_button_x_get
  static final int Function(int) _groupButtonXGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Int8 Function(Uint64), int Function(int)>(
          "group_button_x_get");
  static int groupButtonXGet(int groupId) {
    return _groupButtonXGet(groupId);
  }

  // API void group_button_x_set(id_t group_id, int8_t x);
  // group_button_x_set
  static final void Function(int, int) _groupButtonXSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Int8), void Function(int, int)>(
          "group_button_x_set");
  static void groupButtonXSet(int groupId, int x) {
    _groupButtonXSet(groupId, x);
  }

  // API int8_t group_button_y_get(id_t group_id);
  // group_button_y_get
  static final int Function(int) _groupButtonYGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Int8 Function(Uint64), int Function(int)>(
          "group_button_y_get");
  static int groupButtonYGet(int groupId) {
    return _groupButtonYGet(groupId);
  }

  // API void group_button_y_set(id_t group_id, int8_t y);
  // group_button_y_set
  static final void Function(int, int) _groupButtonYSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Int8), void Function(int, int)>(
          "group_button_y_set");
  static void groupButtonYSet(int groupId, int y) {
    _groupButtonYSet(groupId, y);
  }

  // API void group_press_duration_set(id_t group_id, int64_t duration);
  // group_press_duration_set
  static final void Function(int, int) _groupPressDurationSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Int64), void Function(int, int)>(
          "group_press_duration_set");
  static void groupPressDurationSet(int groupId, int duration) {
    _groupPressDurationSet(groupId, duration);
  }

  // API int64_t group_press_duration_get(id_t group_id);
  // group_press_duration_get
  static final int Function(int) _groupPressDurationGet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Int64 Function(Uint64), int Function(int)>(
          "group_press_duration_get");
  static int groupPressDurationGet(int groupId) {
    return _groupPressDurationGet(groupId);
  }

  // API void group_segment_set(id_t group_id, id_t segment_id);
  // group_segment_set
  static final void Function(int, int) _groupSegmentSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Uint64), void Function(int, int)>(
          "group_segment_set");
  static void groupSegmentSet(int groupId, int segmentId) {
    _groupSegmentSet(groupId, segmentId);
  }

  // API id_t group_segment_get(id_t group_id);
  // group_segment_get
  static final int Function(int) _groupSegmentGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Uint64 Function(Uint64), int Function(int)>(
          "group_segment_get");
  static int groupSegmentGet(int groupId) {
    return _groupSegmentGet(groupId);
  }

  // API void group_start_cue_set(id_t group_id, id_t start_cue_id);
  // group_start_cue_set
  static final void Function(int, int) _groupStartCueSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Uint64), void Function(int, int)>(
          "group_start_cue_set");
  static void groupStartCueSet(int groupId, int startCueId) {
    _groupStartCueSet(groupId, startCueId);
  }

  // API id_t group_start_cue_get(id_t group_id);
  // group_start_cue_get
  static final int Function(int) _groupStartCueGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Uint64 Function(Uint64), int Function(int)>(
          "group_start_cue_get");
  static int groupStartCueGet(int groupId) {
    return _groupStartCueGet(groupId);
  }

  // API void group_lightshow_data_set(id_t group_id, id_t lightshow_data_id);
  // group_lightshow_data_set
  static final void Function(int, int) _groupLightshowDataSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Uint64), void Function(int, int)>(
          "group_lightshow_data_set");
  static void groupLightshowDataSet(int groupId, int lightshowDataId) {
    _groupLightshowDataSet(groupId, lightshowDataId);
  }

  // API id_t group_lightshow_data_get(id_t group_id);
  // group_lightshow_data_get
  static final int Function(int) _groupLightshowDataGet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Uint64 Function(Uint64), int Function(int)>(
          "group_lightshow_data_get");
  static int groupLightshowDataGet(int groupId) {
    return _groupLightshowDataGet(groupId);
  }
  // ==================== TimelineGroup End ====================
}
