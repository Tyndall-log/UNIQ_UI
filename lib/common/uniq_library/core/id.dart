part of '../uniq.dart';

mixin Id {
  int id = 0;
}

// extension IdManager on UniqLibrary {
//   static final Map<int, Id> _idMap = {};
//
//   static Id getId(int id) {
//     if (_idMap.containsKey(id)) {
//       return _idMap[id]!;
//     }
//     final newId = Id(id);
//     _idMap[id] = newId;
//     return newId;
//   }
// }
