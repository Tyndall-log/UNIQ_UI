import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uniq_ui/common/platform.dart';
import 'package:uniq_ui/common/sample_toast.dart';
import 'package:uniq_ui/common/uniq_library/uniq.dart';
import '../default_value.dart';
import '../widgets/grid.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';

var _tapDownTime = DateTime.now().millisecondsSinceEpoch;
var _tapDownPosition = Offset.zero;
var _tapDownLocalPosition = Offset.zero;
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
          details = ScaleStartDetails(
            focalPoint: _tapDownLocalPosition,
            localFocalPoint: _tapDownLocalPosition,
            pointerCount: details.pointerCount,
            sourceTimeStamp: details.sourceTimeStamp,
          );
          context.read<WorkspaceViewBloc>().add(TimeScaleStartEvent(details));
        } else {
          _tapDragFlag = false;
          context.read<WorkspaceViewBloc>().add(ScaleStartEvent(details));
        }
      },
      onScaleUpdate: (details) {
        if (_tapDragFlag) {
          if (details.pointerCount == 1) {
            context
                .read<WorkspaceViewBloc>()
                .add(TimeScaleUpdateEvent(details));
          } else {
            _tapDragFlag = false;
            context.read<WorkspaceViewBloc>().add(TimeScaleEndEvent(
                  ScaleEndDetails(),
                ));
          }
        } else {
          context.read<WorkspaceViewBloc>().add(ScaleUpdateEvent(details));
        }
      },
      onScaleEnd: (details) {
        if (_tapDragFlag) {
          _tapDragFlag = false;
          context.read<WorkspaceViewBloc>().add(TimeScaleEndEvent(details));
        } else {
          context.read<WorkspaceViewBloc>().add(ScaleEndEvent(details));
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
        _tapDownLocalPosition = details.localPosition;
      },
      onSecondaryTapDown: (details) {
        _tapDragFlag = false;
        _tapDownPosition = details.globalPosition;
        _tapDownLocalPosition = details.localPosition;
        _showContextMenu(context);
      },
      child: child,
    );
  }

  void _showContextMenu(BuildContext context) async {
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
      if (!context.mounted) return;
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
              if (!context.mounted) return;
              if (value != null) {
                var workspaceId = context.read<WorkspaceViewBloc>().workspaceId;
                var id = Unipack.load(workspaceId, value.files.first.path!);
                print('unipackId: $id');
                Project.launchpadAutoConnect(id);
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
