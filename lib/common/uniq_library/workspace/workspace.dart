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
}
