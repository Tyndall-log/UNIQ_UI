import 'package:flutter/material.dart';
import '../default_value.dart';

class GridPainter extends CustomPainter {
  final double timeLength;
  // double _previousTimeLength = 0;

  GridPainter(this.timeLength);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = .1;

    var maxWidth = size.width * timeLength / defaultTimeLength + 1;
    for (double i = 0; i < maxWidth; i += 5) {
      if (i % 25 == 0) {
        if (i % 100 == 0) {
          paint.strokeWidth = .5;
        } else {
          paint.strokeWidth = .1;
        }
      } else {
        paint.strokeWidth = .025;
      }
      var x = i * defaultTimeLength / timeLength;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    var maxHeight = size.height + 1;
    for (double i = 0; i < maxHeight; i += 5) {
      if (i % 25 == 0) {
        if (i % 100 == 0) {
          paint.strokeWidth = .5;
        } else {
          paint.strokeWidth = .1;
        }
      } else {
        paint.strokeWidth = .025;
      }
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is GridPainter) {
      return oldDelegate.timeLength != timeLength;
    }
    return false;
  }
}
