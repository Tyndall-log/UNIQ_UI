import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WavePainter extends CustomPainter {
  final List<double> data;
  // final double pixelRatio;

  WavePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final midY = size.height / 2;
    final xStep = 1.0;

    for (int i = 0; i < data.length; i++) {
      final x = i * xStep;
      final y = midY - (data[i] * midY); // 중앙 기준으로 수직 위치
      canvas.drawLine(Offset(x, midY), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPaintExample extends StatelessWidget {
  final List<double> data = [0.1, 0.4, 0.7, 0.9, 0.3, 0.6, 0.2, 0.8, 0.5];

  @override
  Widget build(BuildContext context) {
    // ui.PlatformDispatcher를 통해 devicePixelRatio를 직접 가져옴
    final dpi = ui.PlatformDispatcher.instance.views.first
        .devicePixelRatio; // 기본 DPI 96에 배율 적용
    return Scaffold(
      appBar: AppBar(title: Text("WavePainter Example")),
      body: Center(
        child: CustomPaint(
          size: Size(300, 200),
          painter: WavePainter(data),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: CustomPaintExample()));
}
