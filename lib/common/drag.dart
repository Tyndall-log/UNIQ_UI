import 'package:flutter/material.dart';

class DragDetectionWidget extends StatefulWidget {
  @override
  _DragDetectionWidgetState createState() => _DragDetectionWidgetState();
}

class _DragDetectionWidgetState extends State<DragDetectionWidget> {
  bool isDragging = false;
  bool isPointerInRegion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Listener(
          onPointerDown: (event) {
            print('onPointerDown');
            setState(() {
              isDragging = true;
            });
          },
          onPointerUp: (event) {
            print('onPointerUp');
            setState(() {
              isDragging = false;
              isPointerInRegion = false;
            });
          },
          onPointerMove: (event) {
            print('onPointerMove');
            if (isDragging) {
              setState(() {
                // 포인터가 드래그 ��일 때
              });
            }
          },
          child: MouseRegion(
            onEnter: (event) {
              if (isDragging) {
                setState(() {
                  isPointerInRegion = true;
                });
              }
            },
            onExit: (event) {
              setState(() {
                isPointerInRegion = false;
              });
            },
            child: Container(
              width: 200,
              height: 200,
              color: isPointerInRegion ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
