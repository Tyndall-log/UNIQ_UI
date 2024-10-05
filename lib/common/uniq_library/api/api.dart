part of '../uniq.dart';

extension Api on UniqLibrary {
  static final void Function(Pointer<Uint64>) _idListDelete =
      UniqLibrary._uniqLibrary!.lookupFunction<Void Function(Pointer<Uint64>),
          void Function(Pointer<Uint64>)>('id_list_delete');
}
