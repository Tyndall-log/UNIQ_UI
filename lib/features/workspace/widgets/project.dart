import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uniq_ui/common/uniq_library/uniq.dart';

class ProjectState {
  final int id;
  final List<int> timeLine = [];

  ProjectState({required this.id});
}

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(super.initialState);

  void addTimeLine(int time) {
    state.timeLine.add(time);
    emit(ProjectState(id: state.id));
  }

  @override
  Future<void> close() {
    print('ProjectCubit close() called (state: ${state.id})');
    CallbackManager.unregisterCallbackByObjIdAll(state.id);
    return super.close();
  }
}
