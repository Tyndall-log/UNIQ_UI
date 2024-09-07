part of '../uniq.dart';

typedef _UnipackLoadC = Uint64 Function(Uint64, Pointer<Utf8>);
typedef _UnipackLoad = int Function(int, Pointer<Utf8>);

extension Unipack on UniqLibrary {
  static int load(int workspaceId, String path) {
    final _UnipackLoad unipackLoad = UniqLibrary._uniqLibrary!
        .lookupFunction<_UnipackLoadC, _UnipackLoad>('unipack_load');
    var pathPtr = path.toNativeUtf8();
    var result = unipackLoad(workspaceId, pathPtr);
    calloc.free(pathPtr);
    return result;
  }
}
