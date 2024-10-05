part of '../uniq.dart';

extension Timeline on UniqLibrary {
  // ==================== Timeline Start ====================
  // API void *timeline_name_get(id_t timeline_id);
  // timeline_name_get
  static final Pointer<Utf8> Function(int) _nameGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Pointer<Utf8> Function(Uint64),
          Pointer<Utf8> Function(int)>('timeline_name_get');
  static String nameGet(int timelineId) {
    final Pointer<Utf8> namePtr = _nameGet(timelineId);
    final String result = namePtr.toDartString();
    malloc.free(namePtr);
    return result;
  }

  // API void timeline_name_set(id_t timeline_id, const char *name);
  // timeline_name_set
  static final void Function(int, Pointer<Utf8>) _nameSet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Pointer<Utf8>),
          void Function(int, Pointer<Utf8>)>('timeline_name_set');
  static void nameSet(int timelineId, String name) {
    final Pointer<Utf8> namePtr = name.toNativeUtf8();
    _nameSet(timelineId, namePtr);
    malloc.free(namePtr);
  }

  // API void timeline_group_add(id_t timeline_id, id_t group_id);
  // timeline_group_add
  static final void Function(int, int) _groupAdd = UniqLibrary._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Uint64), void Function(int, int)>(
          'timeline_group_add');
  static void groupAdd(int timelineId, int groupId) {
    _groupAdd(timelineId, groupId);
  }

  // API void timeline_group_remove(id_t timeline_id, id_t group_id);
  // timeline_group_remove
  static final void Function(int, int) _groupRemove = UniqLibrary._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Uint64), void Function(int, int)>(
          'timeline_group_remove');
  static void groupRemove(int timelineId, int groupId) {
    _groupRemove(timelineId, groupId);
  }
  // ==================== Timeline End ====================
}
