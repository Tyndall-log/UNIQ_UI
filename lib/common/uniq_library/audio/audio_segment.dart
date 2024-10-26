part of '../uniq.dart';

extension AudioSegment on UniqLibrary {
  // API float *waveform_get(id_t segment_id, uint64_t window_size, uint8_t channel);
  // waveform_get
  static final Pointer<Float> Function(int, int, int) _waveformGet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Float> Function(Uint64, Uint64, Uint8),
          Pointer<Float> Function(int, int, int)>('waveform_get');
  static List<double> waveformGet(int segmentId, int windowSize, int channel) {
    final Pointer<Float> waveformPtr =
        _waveformGet(segmentId, windowSize, channel);
    if (waveformPtr.address == 0) return [];
    final List<double> result = waveformPtr.asTypedList(windowSize).toList();
    malloc.free(waveformPtr);
    return result;
  }

  //API float* waveform_get_part(id_t segment_id, int64_t start, int64_t end, uint64_t window_size, uint8_t channel);
  //waveform_get_part
  static final Pointer<Float> Function(int, int, int, int, int)
      _waveformGetPart = UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Float> Function(Uint64, Int64, Int64, Uint64, Uint8),
          Pointer<Float> Function(
              int, int, int, int, int)>('waveform_get_part');
  static List<double> waveformGetPart(
      int segmentId, int start, int end, int windowSize, int channel) {
    final Pointer<Float> waveformPtr =
        _waveformGetPart(segmentId, start, end, windowSize, channel);
    if (waveformPtr.address == 0) return [];
    final List<double> result = waveformPtr.asTypedList(windowSize).toList();
    malloc.free(waveformPtr);
    return result;
  }
}
