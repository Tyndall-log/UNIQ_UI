part of '../uniq.dart';

extension AudioSource on UniqLibrary {
  // API void audio_source_play(id_t source_id, id_t player_id);
  static final void Function(int, int) _audioSourcePlay = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Uint64), void Function(int, int)>(
          'audio_source_play');
  static void audioSourcePlay(int sourceId, int playerId) {
    _audioSourcePlay(sourceId, playerId);
  }

  // API bool audio_source_cue_add(id_t source_id, uint64_t cue);
  static final bool Function(int, int) _audioSourceCueAdd = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64, Uint64), bool Function(int, int)>(
          'audio_source_cue_add');
  static bool audioSourceCueAdd(int sourceId, int cue) {
    return _audioSourceCueAdd(sourceId, cue);
  }

  // API bool audio_source_cue_remove(id_t source_id, uint64_t cue);
  static final bool Function(int, int) _audioSourceCueRemove = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64, Uint64), bool Function(int, int)>(
          'audio_source_cue_remove');
  static bool audioSourceCueRemove(int sourceId, int cue) {
    return _audioSourceCueRemove(sourceId, cue);
  }

  // API std::uint64_t* audio_source_cue_list_get(id_t source_id, std::size_t* list_len);
  // audio_source_cue_list_get
  static final Pointer<Uint64> Function(int, Pointer<IntPtr>)
      _audioSourceCueListGet = UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Uint64> Function(Uint64, Pointer<IntPtr>),
          Pointer<Uint64> Function(
              int, Pointer<IntPtr>)>('audio_source_cue_list_get');
  static List<int> audioSourceCueListGet(int sourceId) {
    final Pointer<IntPtr> listLenPtr = malloc<IntPtr>();
    final Pointer<Uint64> cueListPtr =
        _audioSourceCueListGet(sourceId, listLenPtr);
    final int listLen = listLenPtr.value;
    final List<int> result = cueListPtr.asTypedList(listLen).toList();
    malloc.free(listLenPtr);
    malloc.free(cueListPtr);
    return result;
  }

  // API bool audio_source_segment_create(id_t source_id, uint64_t cue, const char* name);
  static final bool Function(int, int, Pointer<Utf8>)
      _audioSourceSegmentCreate = UniqLibrary._uniqLibrary!.lookupFunction<
          Bool Function(Uint64, Uint64, Pointer<Utf8>),
          bool Function(
              int, int, Pointer<Utf8>)>('audio_source_segment_create');
  static bool audioSourceSegmentCreate(int sourceId, int cue, String name) {
    final Pointer<Utf8> namePtr = name.toNativeUtf8();
    final bool result = _audioSourceSegmentCreate(sourceId, cue, namePtr);
    malloc.free(namePtr);
    return result;
  }

  // API float*** audio_source_waveform_get_raw(id_t source_id);
  static final Pointer<Pointer<Pointer<Float>>> Function(int)
      _audioSourceWaveformGetRaw = UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Pointer<Pointer<Float>>> Function(Uint64),
          Pointer<Pointer<Pointer<Float>>> Function(
              int)>('audio_source_waveform_get_raw');
  static Pointer<Pointer<Pointer<Float>>> audioSourceWaveformGetRaw(
      int sourceId) {
    return _audioSourceWaveformGetRaw(sourceId);
  }

  // API float* audio_source_waveform_get(id_t source_id, uint64_t window_size, uint8_t channel);
  static final Pointer<Float> Function(int, int, int) _audioSourceWaveformGet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Float> Function(Uint64, Uint64, Uint8),
          Pointer<Float> Function(int, int, int)>('audio_source_waveform_get');
  static Pointer<Float> audioSourceWaveformGet(
      int sourceId, int windowSize, int channel) {
    return _audioSourceWaveformGet(sourceId, windowSize, channel);
  }

  // API float* audio_source_waveform_get_part(id_t source_id, int64_t start, int64_t end, uint64_t window_size, uint8_t channel);
  // audio_source_waveform_get_part
  static final Pointer<Float> Function(int, int, int, int, int)
      _audioSourceWaveformGetPart = UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Float> Function(Uint64, Int64, Int64, Uint64, Uint8),
          Pointer<Float> Function(
              int, int, int, int, int)>('audio_source_waveform_get_part');
  static List<double> audioSourceWaveformGetPart(
      int sourceId, int start, int end, int windowSize, int channel) {
    final Pointer<Float> waveformPtr =
        _audioSourceWaveformGetPart(sourceId, start, end, windowSize, channel);
    if (waveformPtr.address == 0) return [];
    final List<double> result = waveformPtr.asTypedList(windowSize).toList();
    malloc.free(waveformPtr);
    return result;
  }
}
