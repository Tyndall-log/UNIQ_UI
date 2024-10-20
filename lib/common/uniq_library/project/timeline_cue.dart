part of '../uniq.dart';

extension TimelineCue on UniqLibrary {
  // ==================== TimelineCue Start ====================
  // API void uniq::project::timeline_cue::cue_point_set(const cue_point_t)
  // cue_point_set
  static final void Function(int, int) _cuePointSet = UniqLibrary._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Int64), void Function(int, int)>(
          'cue_point_set');
  static void cuePointSet(int timelineId, int cue) {
    _cuePointSet(timelineId, cue);
  }

  // API int64_t uniq::project::timeline_cue::cue_point_get()
  // cue_point_get
  static final int Function(int) _cuePointGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Int64 Function(Uint64), int Function(int)>(
          'cue_point_get');
  static int cuePointGet(int timelineId) {
    return _cuePointGet(timelineId);
  }
  // ==================== TimelineCue End ====================
}
