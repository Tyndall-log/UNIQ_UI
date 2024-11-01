// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_editer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioSourceViewState {
  double get position => throw _privateConstructorUsedError; // 샘플 위치
// required double scale,
  double get level => throw _privateConstructorUsedError; // 샘플 크기
  AudioSourceCubit? get audioSourceCubit => throw _privateConstructorUsedError;

  /// Create a copy of AudioSourceViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioSourceViewStateCopyWith<AudioSourceViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioSourceViewStateCopyWith<$Res> {
  factory $AudioSourceViewStateCopyWith(AudioSourceViewState value,
          $Res Function(AudioSourceViewState) then) =
      _$AudioSourceViewStateCopyWithImpl<$Res, AudioSourceViewState>;
  @useResult
  $Res call(
      {double position, double level, AudioSourceCubit? audioSourceCubit});
}

/// @nodoc
class _$AudioSourceViewStateCopyWithImpl<$Res,
        $Val extends AudioSourceViewState>
    implements $AudioSourceViewStateCopyWith<$Res> {
  _$AudioSourceViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioSourceViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? level = null,
    Object? audioSourceCubit = freezed,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as double,
      audioSourceCubit: freezed == audioSourceCubit
          ? _value.audioSourceCubit
          : audioSourceCubit // ignore: cast_nullable_to_non_nullable
              as AudioSourceCubit?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioSorceViewStateImplCopyWith<$Res>
    implements $AudioSourceViewStateCopyWith<$Res> {
  factory _$$AudioSorceViewStateImplCopyWith(_$AudioSorceViewStateImpl value,
          $Res Function(_$AudioSorceViewStateImpl) then) =
      __$$AudioSorceViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double position, double level, AudioSourceCubit? audioSourceCubit});
}

/// @nodoc
class __$$AudioSorceViewStateImplCopyWithImpl<$Res>
    extends _$AudioSourceViewStateCopyWithImpl<$Res, _$AudioSorceViewStateImpl>
    implements _$$AudioSorceViewStateImplCopyWith<$Res> {
  __$$AudioSorceViewStateImplCopyWithImpl(_$AudioSorceViewStateImpl _value,
      $Res Function(_$AudioSorceViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioSourceViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? level = null,
    Object? audioSourceCubit = freezed,
  }) {
    return _then(_$AudioSorceViewStateImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as double,
      audioSourceCubit: freezed == audioSourceCubit
          ? _value.audioSourceCubit
          : audioSourceCubit // ignore: cast_nullable_to_non_nullable
              as AudioSourceCubit?,
    ));
  }
}

/// @nodoc

class _$AudioSorceViewStateImpl extends _AudioSorceViewState {
  const _$AudioSorceViewStateImpl(
      {this.position = 0, this.level = 8, this.audioSourceCubit})
      : super._();

  @override
  @JsonKey()
  final double position;
// 샘플 위치
// required double scale,
  @override
  @JsonKey()
  final double level;
// 샘플 크기
  @override
  final AudioSourceCubit? audioSourceCubit;

  @override
  String toString() {
    return 'AudioSourceViewState(position: $position, level: $level, audioSourceCubit: $audioSourceCubit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioSorceViewStateImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.audioSourceCubit, audioSourceCubit) ||
                other.audioSourceCubit == audioSourceCubit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, position, level, audioSourceCubit);

  /// Create a copy of AudioSourceViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioSorceViewStateImplCopyWith<_$AudioSorceViewStateImpl> get copyWith =>
      __$$AudioSorceViewStateImplCopyWithImpl<_$AudioSorceViewStateImpl>(
          this, _$identity);
}

abstract class _AudioSorceViewState extends AudioSourceViewState {
  const factory _AudioSorceViewState(
      {final double position,
      final double level,
      final AudioSourceCubit? audioSourceCubit}) = _$AudioSorceViewStateImpl;
  const _AudioSorceViewState._() : super._();

  @override
  double get position; // 샘플 위치
// required double scale,
  @override
  double get level; // 샘플 크기
  @override
  AudioSourceCubit? get audioSourceCubit;

  /// Create a copy of AudioSourceViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioSorceViewStateImplCopyWith<_$AudioSorceViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
