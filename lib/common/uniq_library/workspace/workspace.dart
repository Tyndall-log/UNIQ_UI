part of '../uniq.dart';

typedef _WorkspaceCreateC = Uint64 Function();
typedef _WorkspaceCreate = int Function();
typedef _WorkspaceDestroyC = Bool Function(Uint64);
typedef _WorkspaceDestroy = bool Function(int);

extension Workspace on UniqLibrary {
  static int create() {
    final _WorkspaceCreate workspaceCreate = UniqLibrary._uniqLibrary!
        .lookupFunction<_WorkspaceCreateC, _WorkspaceCreate>(
            'workspace_create');
    return workspaceCreate();
  }

  static bool destroy(int workspaceId) {
    final _WorkspaceDestroy workspaceDestroy = UniqLibrary._uniqLibrary!
        .lookupFunction<_WorkspaceDestroyC, _WorkspaceDestroy>(
            'workspace_destroy');
    return workspaceDestroy(workspaceId);
  }

  // ==================== Workspace Start ====================
  // workspace_project_create
  static final int Function(int) _projectCreate = UniqLibrary._uniqLibrary!
      .lookupFunction<Uint64 Function(Uint64), int Function(int)>(
          'workspace_project_create');
  static int projectCreate(int workspaceId) {
    return _projectCreate(workspaceId);
  }

  // workspace_project_add
  static final bool Function(int, int) _projectAdd = UniqLibrary._uniqLibrary!
      .lookupFunction<Bool Function(Uint64, Uint64), bool Function(int, int)>(
          'workspace_project_add');
  static bool projectAdd(int workspaceId, int projectId) {
    return _projectAdd(workspaceId, projectId);
  }

  // workspace_project_remove
  static final bool Function(int, int) _projectRemove = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Bool Function(Uint64, Uint64), bool Function(int, int)>(
          'workspace_project_remove');
  static bool projectRemove(int workspaceId, int projectId) {
    return _projectRemove(workspaceId, projectId);
  }

  //workspace_project_list_get
  static final Pointer<Uint64> Function(int, Pointer<Uint64>) _projectListGet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Uint64> Function(Uint64, Pointer<Uint64>),
          Pointer<Uint64> Function(
              int, Pointer<Uint64>)>('workspace_project_list_get');
  static List<int> projectListGet(int workspaceId) {
    return using((Arena arena) {
      final Pointer<Uint64> sizePtr = arena<Uint64>();
      final Pointer<Uint64> listPtr = _projectListGet(workspaceId, sizePtr);
      final int size = sizePtr.value;
      final List<int> projectIds =
          List<int>.generate(size, (index) => listPtr[index]);
      Api._idListDelete(listPtr);
      return projectIds;
    });
  }

  // workspace_name_set
  static final void Function(int, Pointer<Utf8>) _nameSet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Pointer<Utf8>),
          void Function(int, Pointer<Utf8>)>('workspace_name_set');
  static void nameSet(int workspaceId, String name) {
    final Pointer<Utf8> namePtr = name.toNativeUtf8();
    _nameSet(workspaceId, namePtr);
    malloc.free(namePtr);
  }

  // workspace_name_get
  static final Pointer<Utf8> Function(int) _nameGet = UniqLibrary._uniqLibrary!
      .lookupFunction<Pointer<Utf8> Function(Uint64),
          Pointer<Utf8> Function(int)>('workspace_name_get');
  static String nameGet(int workspaceId) {
    final Pointer<Utf8> namePtr = _nameGet(workspaceId);
    final String name = namePtr.toDartString();
    malloc.free(namePtr);
    return name;
  }
}
