import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MoveDrag extends Drag {
  Offset mouseGlobalPosition;
  Offset initialOffset;

  MoveDrag({required this.mouseGlobalPosition, required this.initialOffset});

  @override
  void cancel() {
    // print('cancel');
  }

  @override
  void end(DragEndDetails details) {
    // print('end');
  }

  @override
  void update(DragUpdateDetails details) {
    print('update');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Drag & Listener Example')),
        body: DragListenerExample(),
      ),
    );
  }
}

class DragListenerExample extends StatefulWidget {
  @override
  _DragListenerExampleState createState() => _DragListenerExampleState();
}

class _DragListenerExampleState extends State<DragListenerExample> {
  Offset _dragPosition = Offset(100, 100);
  bool _isInsideTarget = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Target area to detect if draggable enters
        Listener(
          onPointerMove: (event) {
            setState(() {
              _isInsideTarget = _checkIfInsideTarget(event.position);
            });
          },
          onPointerHover: (event) {
            // setState(() {
            //   _isInsideTarget = _checkIfInsideTarget(event.position);
            // });
            print('onPointerHover');
          },
          onPointerSignal: (event) {
            print('onPointerSignal');
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Container(
                key: _targetKey,
                width: 150,
                height: 150,
                color: _isInsideTarget ? Colors.green : Colors.red,
                child: Center(child: Text('Target Area')),
              ),
            ),
          ),
        ),
        Positioned(
          left: 200,
          top: 200,
          child: RawGestureDetector(
            gestures: <Type, GestureRecognizerFactory>{
              DelayedMultiDragGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      DelayedMultiDragGestureRecognizer>(
                () => DelayedMultiDragGestureRecognizer(
                  delay: Duration(milliseconds: 100),
                ),
                (DelayedMultiDragGestureRecognizer instance) {
                  instance.onStart = (Offset offset) {
                    return MoveDrag(
                      mouseGlobalPosition: offset,
                      initialOffset: offset,
                    );
                  };
                },
              ),
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
          ),
        ),

        // Draggable widget
        Positioned(
          left: _dragPosition.dx,
          top: _dragPosition.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _dragPosition += details.delta;
              });
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Center(child: Text('Drag me')),
            ),
          ),
        ),
      ],
    );
  }

  final GlobalKey _targetKey = GlobalKey();

  bool _checkIfInsideTarget(Offset position) {
    final RenderBox targetRenderBox =
        _targetKey.currentContext!.findRenderObject() as RenderBox;
    final targetPosition = targetRenderBox.localToGlobal(Offset.zero);
    final targetSize = targetRenderBox.size;
    final targetRect = targetPosition & targetSize;

    return targetRect.contains(position);
  }
}
