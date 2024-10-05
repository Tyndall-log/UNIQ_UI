part of '../uniq.dart';

extension LaunchpadManager on UniqLibrary {
  // ==================== Launchpad Manager Start ====================
  // launchpad_list_get
  static final Pointer<Uint64> Function(Pointer<Uint64>) _launchpadListGet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Pointer<Uint64> Function(Pointer<Uint64>),
          Pointer<Uint64> Function(Pointer<Uint64>)>('launchpad_list_get');
  static List<int> launchpadListGet() {
    return using((Arena arena) {
      final Pointer<Uint64> sizePtr = arena<Uint64>();
      final Pointer<Uint64> listPtr = _launchpadListGet(sizePtr);
      final int size = sizePtr.value;
      final List<int> launchpadIds =
          List<int>.generate(size, (index) => listPtr[index]);
      Api._idListDelete(listPtr);
      return launchpadIds;
    });
  }
// ==================== Launchpad Manager End ====================
}

extension Launchpad on UniqLibrary {
  // ==================== Launchpad Start ====================
  // rgb_set
  static final void Function(int, int, int, int, int, int) _rgbSet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Uint8, Uint8, Uint8, Uint8, Uint8),
          void Function(int, int, int, int, int, int)>('rgb_set');
  static void rgbSet(int launchpadId, int x, int y, int r, int g, int b) {
    _rgbSet(launchpadId, x, y, r, g, b);
  }

  // velocity_set
  static final void Function(int, int, int, int) _velocitySet =
      UniqLibrary._uniqLibrary!.lookupFunction<
          Void Function(Uint64, Uint8, Uint8, Uint8),
          void Function(int, int, int, int)>('velocity_set');
  static void velocitySet(int launchpadId, int x, int y, int velocity) {
    _velocitySet(launchpadId, x, y, velocity);
  }

  // program_mode_set
  static final void Function(int, bool) _programModeSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Bool), void Function(int, bool)>(
          'program_mode_set');
  static void programModeSet(int launchpadId, bool flag) {
    _programModeSet(launchpadId, flag);
  }

  // automatic_transmission_set
  static final void Function(int, bool) _automaticTransmissionSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Bool), void Function(int, bool)>(
          'automatic_transmission_set');
  static void automaticTransmissionSet(int launchpadId, bool flag) {
    _automaticTransmissionSet(launchpadId, flag);
  }

  // immediate_transmission_set
  static final void Function(int, bool) _immediateTransmissionSet = UniqLibrary
      ._uniqLibrary!
      .lookupFunction<Void Function(Uint64, Bool), void Function(int, bool)>(
          'immediate_transmission_set');
  static void immediateTransmissionSet(int launchpadId, bool flag) {
    _immediateTransmissionSet(launchpadId, flag);
  }
// ==================== Launchpad End ====================
}
