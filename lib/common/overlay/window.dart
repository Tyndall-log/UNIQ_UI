// import 'dart:async';
// import 'package:flutter/material.dart';
//
// OverlayEntry window({
//   // required BuildContext context,
//   required OverlayState overlayState,
//   required double x,
//   required double y,
//   required String title,
//   IconData? icon,
//   Widget? content,
//   Future<bool?> Function()? onClose,
// }) {
//   OverlayEntry? overlayEntry;
//
//   overlayEntry = OverlayEntry(
//     builder: (context) {
//       return Positioned(
//         top: y,
//         left: x,
//         child: Material(
//           color: Colors.transparent,
//           child: GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTap: () {},
//             onPanUpdate: (details) {
//               x += details.delta.dx;
//               y += details.delta.dy;
//               overlayEntry!.markNeedsBuild();
//             },
//             child: Container(
//               width: 250,
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10.0,
//                     spreadRadius: 1.0,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         if (icon != null)
//                           Icon(
//                             icon,
//                             size: 18,
//                           ),
//                         Text(
//                           title,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             overlayEntry?.remove();
//                           },
//                           child: const Icon(Icons.close),
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (content != null) content,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
//
//   overlayState.insert(overlayEntry);
//
//   return overlayEntry;
// }

import 'dart:async';
import 'package:flutter/material.dart';

import '../uniq_library/uniq.dart';

class LogWindow extends StatefulWidget {
  final OverlayState overlayState;
  final double x;
  final double y;
  final String title;
  final IconData? icon;
  final Widget? content;
  final Future<bool?> Function()? onClose;

  const LogWindow({
    required this.overlayState,
    required this.x,
    required this.y,
    required this.title,
    this.icon,
    this.content,
    this.onClose,
  });

  @override
  _LogWindowState createState() => _LogWindowState();
}

class _LogWindowState extends State<LogWindow> {
  late OverlayEntry _overlayEntry;
  late double _x;
  late double _y;
  List<String> logs = ["초기 로그"];

  @override
  void initState() {
    super.initState();
    _x = widget.x;
    _y = widget.y;
    _overlayEntry = _createOverlayEntry();
    widget.overlayState.insert(_overlayEntry);
    Loger.addLogCallback(addLog);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: _y,
          left: _x,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanUpdate: (details) {
                setState(() {
                  _x += details.delta.dx;
                  _y += details.delta.dy;
                });
                _overlayEntry.markNeedsBuild();
              },
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.icon != null)
                            Icon(
                              widget.icon,
                              size: 18,
                            ),
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _overlayEntry.remove();
                              if (widget.onClose != null) {
                                widget.onClose!();
                              }
                            },
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: logs.length,
                        itemBuilder: (context, index) {
                          return Text(logs[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addLog(String log) {
    setState(() {
      logs.add(log);
      if (logs.length > 1000) logs.removeAt(0); // 로그 수 제한
      _overlayEntry.markNeedsBuild();
    });
  }

  @override
  void dispose() {
    _overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // 실제로는 아무것도 렌더링하지 않음
  }
}
