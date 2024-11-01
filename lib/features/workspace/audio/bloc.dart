import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc.freezed.dart';

@freezed
class AudioEditorState with _$AudioEditorState {
  const AudioEditorState._();
  const factory AudioEditorState() = _AudioEditorState;
}

class AudioEditorCubit extends Cubit<AudioEditorState> {
  AudioEditorCubit() : super(AudioEditorState());

  // void someFunction() {
  //   emit(state.copyWith());
  // }
}
