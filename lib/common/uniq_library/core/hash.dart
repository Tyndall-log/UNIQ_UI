part of '../uniq.dart';

extension Hash on UniqLibrary {
  static int fnv1aHash(String str) {
    return fnv1_64_s(str);
  }
}
