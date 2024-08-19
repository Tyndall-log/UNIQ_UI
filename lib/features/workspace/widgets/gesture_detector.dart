import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uniq_ui/common/platform.dart';
import 'package:uniq_ui/common/sample_toast.dart';
import '../default_value.dart';
import '../widgets/grid.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';

var _tapDownTime = DateTime.now().millisecondsSinceEpoch;
var _tapDownPosition = Offset.zero;
int _tapDragTimeDeadline = 300;
bool _tapDragFlag = false;

class WorkspaceGestureDetector extends StatelessWidget {
  final Widget? child;
  const WorkspaceGestureDetector({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onScaleStart: (details) {
        if (_tapDragFlag && details.pointerCount == 1) {
          print(_tapDownPosition);
          print(details.focalPoint);
          print(details.localFocalPoint);
          details = ScaleStartDetails(
            focalPoint: _tapDownPosition,
            localFocalPoint: _tapDownPosition,
            pointerCount: details.pointerCount,
            sourceTimeStamp: details.sourceTimeStamp,
          );
          context.read<WorkspaceBloc>().add(TimeScaleStartEvent(details));
        } else {
          _tapDragFlag = false;
          context.read<WorkspaceBloc>().add(ScaleStartEvent(details));
        }
        // print('Scale Start: ${details.focalPoint}');
      },
      onScaleUpdate: (details) {
        if (_tapDragFlag) {
          if (details.pointerCount == 1) {
            context.read<WorkspaceBloc>().add(TimeScaleUpdateEvent(details));
          } else {
            _tapDragFlag = false;
            context.read<WorkspaceBloc>().add(TimeScaleEndEvent(
                  ScaleEndDetails(),
                ));
          }
        } else {
          context.read<WorkspaceBloc>().add(ScaleUpdateEvent(details));
        }
      },
      onScaleEnd: (details) {
        if (_tapDragFlag) {
          _tapDragFlag = false;
          context.read<WorkspaceBloc>().add(TimeScaleEndEvent(details));
        } else {
          context.read<WorkspaceBloc>().add(ScaleEndEvent(details));
        }
      },
      onTap: () => print('Tapped'),
      // onTapCancel: () {
      //   print('Tap Cancel');
      // },
      onDoubleTap: () {
        _tapDragFlag = false;
        print('Double Tapped');
      },
      onLongPress: () => _showContextMenu(context),
      // onHorizontalDragStart: (_) => print('Horizontal Drag Start'),
      onLongPressStart: (details) {
        _tapDragFlag = false;
      },
      onLongPressDown: (details) {
        var now = DateTime.now().millisecondsSinceEpoch;
        var limit = desktopPlatform ? 10 : 50;
        if (now - _tapDownTime < _tapDragTimeDeadline &&
            (_tapDownPosition - details.globalPosition).distance < limit) {
          _tapDragFlag = true;
          return;
        }
        _tapDownTime = now;
        _tapDownPosition = details.globalPosition;
      },
      onSecondaryTapDown: (details) {
        _tapDragFlag = false;
        _tapDownPosition = details.globalPosition;
        _showContextMenu(context);
      },
      child: child,
    );
  }

  void _showContextMenu(context) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapDownPosition & Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: Text('여기에 새 프로젝트 생성'),
          value: 1,
        ),
        PopupMenuItem(
          child: Text('프로젝트 불러오기'),
          value: 2,
        ),
        PopupMenuItem(
          child: Text('유니팩 불러오기'),
          value: 3,
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 1:
            SampleToast.show(
              context: context,
              title: '새 프로젝트 생성',
              description: '아직 지원하지 않는 기능입니다.',
              type: ToastificationType.error,
            );
            break;
          case 2:
            SampleToast.show(
              context: context,
              title: '프로젝트 불러오기',
              description: '아직 지원하지 않는 기능입니다.',
              type: ToastificationType.error,
            );
            break;
          case 3:
            FilePicker.platform.pickFiles(
              dialogTitle: '유니팩 불러오기',
              type: FileType.custom,
              allowedExtensions: ['zip', 'uni'],
            ).then((value) {
              if (value != null) {
                print(value.files.first.name);
              } else {
                SampleToast.show(
                  context: context,
                  title: '유니팩 불러오기 실패',
                  description: '사용자가 파일을 선택하지 않았습니다.',
                  type: ToastificationType.error,
                );
              }
            });
            break;
        }
      }
    });
  }
}
