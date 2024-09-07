import 'dart:async';
import 'package:flutter/material.dart';

Future<bool?> message({
  // required BuildContext context,
  required OverlayState overlayState,
  required double x,
  required double y,
  String? title,
  String? text,
  Widget? content,
  Future<bool?> Function()? onConfirm,
  Future<bool?> Function()? onCancel,
  Future<bool?> Function()? onIgnore,
  Future<void> Function()? onClose,
}) async {
  OverlayEntry? overlayEntry;
  BuildContext context = WidgetsBinding.instance.rootElement!;
  // OverlayState overlayState = Overlay.of(context);
  Completer<bool?> completer = Completer<bool?>();

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) => GestureDetector(
      onTap: () {
        overlayEntry?.remove();
        if (onIgnore != null) {
          completer.complete(onIgnore());
        } else {
          completer.complete(null);
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: y,
              left: x,
              child: GestureDetector(
                onPanUpdate: (details) {
                  x += details.delta.dx;
                  y += details.delta.dy;
                  overlayEntry!.markNeedsBuild();
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        if (text != null) const SizedBox(height: 10),
                        if (text != null)
                          Text(
                            text,
                            style: const TextStyle(fontSize: 16),
                          ),
                        if (content != null) content,
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                overlayEntry?.remove();
                                completer.complete(await onCancel!());
                              },
                              child: const Text('취소'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                overlayEntry?.remove();
                                completer.complete(await onConfirm!());
                              },
                              child: const Text('확인'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  if (onClose != null) {
    completer.future.whenComplete(onClose);
  }

  return completer.future;
}
