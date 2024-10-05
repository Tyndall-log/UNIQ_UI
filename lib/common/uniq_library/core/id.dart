part of '../uniq.dart';

class Id {
  final int id;
  final int workspaceId;

  Id({required this.id}) : workspaceId = IdManager.getWorkspaceId(id);
}

extension IdManager on UniqLibrary {
  // get_workspace_ID
  static final int Function(int) _getWorkspaceId = UniqLibrary._uniqLibrary!
      .lookupFunction<Uint64 Function(Uint64), int Function(int)>(
          'workspace_ID_get');
  static int getWorkspaceId(int id) {
    return _getWorkspaceId(id);
  }
}
