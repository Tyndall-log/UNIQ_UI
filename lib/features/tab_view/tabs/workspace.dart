import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/uniq_library/uniq.dart';
import '../tab_bar.dart';
import '/common/overlay/message.dart';

import '../../workspace/screen.dart';

class WorkspaceTab extends TabItem {
  WorkspaceTab({required int workspaceId})
      : super(
          tabBar: const Text('새 프로젝트'),
          tabContent: WorkspaceScreen(id: workspaceId),
          icon: Icons.work,
          onClose: (tabBloc) async {
            var r = await message(
                overlayState: tabBloc.overlayState,
                x: 100,
                y: 100,
                title: '경고',
                // text: '저장하지 않은 프로젝트는 삭제됩니다. 계속하시겠습니까?',
                text: '정말 탭을 닫으시겠습니까? 저장하지 않은 내용는 삭제됩니다.',
                onConfirm: () async {
                  print('확인 선택됨');
                  Workspace.destroy(workspaceId);
                  return true;
                },
                onCancel: () async {
                  print('취소 선택됨');
                  return false;
                },
                onIgnore: () async {
                  print('무시 선택됨');
                  return null;
                },
                onClose: () async {
                  print('다이얼로그 닫힘');
                });
            return r ?? false;
          },
        );
}
