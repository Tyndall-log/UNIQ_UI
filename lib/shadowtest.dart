import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Capture Shadow')),
      body: CaptureShadowWidget(),
    ),
  ));
}

class CaptureShadowWidget extends StatefulWidget {
  @override
  _CaptureShadowWidgetState createState() => _CaptureShadowWidgetState();
}

class _CaptureShadowWidgetState extends State<CaptureShadowWidget> {
  GlobalKey _globalKey = GlobalKey();
  ui.Image? _capturedImage;

  // 위젯을 캡처해서 이미지로 변환하는 메소드
  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var pixelRatio =
        ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    // final OffsetLayer offsetLayer = boundary.layer! as OffsetLayer;
    // final ui.Image image = await offsetLayer.toImage(
    //     Offset(-20, -20) & (boundary.size + Offset(40, 40)),
    //     pixelRatio: pixelRatio);
    setState(() {
      _capturedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 캡처할 위젯을 감싸는 RepaintBoundary
          RepaintBoundary(
            key: _globalKey,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.5),
                //     blurRadius: 10,
                //     spreadRadius: 5,
                //   ),
                // ],
                borderRadius: BorderRadius.circular(50),
              ),
              // color: Colors.blue,
              child: Center(
                child: Text('Capture me!'),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _capturePng,
            child: Text('Capture Widget'),
          ),
          SizedBox(height: 20),
          // 캡처된 이미지를 표시
          _capturedImage != null
              ? CustomPaint(
                  painter: ShadowPainter(_capturedImage!),
                  size: Size(200, 200),
                )
              : Container(),
        ],
      ),
    );
  }
}

class ShadowPainter extends CustomPainter {
  final ui.Image image;

  ShadowPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..blendMode = BlendMode.srcATop
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);
    var pixelRatio =
        ui.PlatformDispatcher.instance.views.first.devicePixelRatio;

    canvas.scale(1 / pixelRatio, 1 / pixelRatio);
    // 그림자 적용
    canvas.drawImage(image, Offset(300, 300), shadowPaint);

    // 실제 이미지 그리기
    canvas.drawImage(image, Offset(0, 0), Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
