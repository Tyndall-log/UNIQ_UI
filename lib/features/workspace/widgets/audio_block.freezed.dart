// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioBlockState {
  Id get idInfo => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;
  int get audioSourceId => throw _privateConstructorUsedError;
  int get audioCueStartId => throw _privateConstructorUsedError;
  int get audioCueEndId => throw _privateConstructorUsedError;

  /// Create a copy of AudioBlockState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioBlockStateCopyWith<AudioBlockState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioBlockStateCopyWith<$Res> {
  factory $AudioBlockStateCopyWith(
          AudioBlockState value, $Res Function(AudioBlockState) then) =
      _$AudioBlockStateCopyWithImpl<$Res, AudioBlockState>;
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      int audioSourceId,
      int audioCueStartId,
      int audioCueEndId});
}

/// @nodoc
class _$AudioBlockStateCopyWithImpl<$Res, $Val extends AudioBlockState>
    implements $AudioBlockStateCopyWith<$Res> {
  _$AudioBlockStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioBlockState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? audioSourceId = null,
    Object? audioCueStartId = null,
    Object? audioCueEndId = null,
  }) {
    return _then(_value.copyWith(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      audioSourceId: null == audioSourceId
          ? _value.audioSourceId
          : audioSourceId // ignore: cast_nullable_to_non_nullable
              as int,
      audioCueStartId: null == audioCueStartId
          ? _value.audioCueStartId
          : audioCueStartId // ignore: cast_nullable_to_non_nullable
              as int,
      audioCueEndId: null == audioCueEndId
          ? _value.audioCueEndId
          : audioCueEndId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioBlockStateImplCopyWith<$Res>
    implements $AudioBlockStateCopyWith<$Res> {
  factory _$$AudioBlockStateImplCopyWith(_$AudioBlockStateImpl value,
          $Res Function(_$AudioBlockStateImpl) then) =
      __$$AudioBlockStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      int audioSourceId,
      int audioCueStartId,
      int audioCueEndId});
}

/// @nodoc
class __$$AudioBlockStateImplCopyWithImpl<$Res>
    extends _$AudioBlockStateCopyWithImpl<$Res, _$AudioBlockStateImpl>
    implements _$$AudioBlockStateImplCopyWith<$Res> {
  __$$AudioBlockStateImplCopyWithImpl(
      _$AudioBlockStateImpl _value, $Res Function(_$AudioBlockStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioBlockState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? audioSourceId = null,
    Object? audioCueStartId = null,
    Object? audioCueEndId = null,
  }) {
    return _then(_$AudioBlockStateImpl(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      audioSourceId: null == audioSourceId
          ? _value.audioSourceId
          : audioSourceId // ignore: cast_nullable_to_non_nullable
              as int,
      audioCueStartId: null == audioCueStartId
          ? _value.audioCueStartId
          : audioCueStartId // ignore: cast_nullable_to_non_nullable
              as int,
      audioCueEndId: null == audioCueEndId
          ? _value.audioCueEndId
          : audioCueEndId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AudioBlockStateImpl extends _AudioBlockState {
  _$AudioBlockStateImpl(
      {required this.idInfo,
      required this.offset,
      this.audioSourceId = 0,
      this.audioCueStartId = 0,
      this.audioCueEndId = 0})
      : super._();

  @override
  final Id idInfo;
  @override
  final Offset offset;
  @override
  @JsonKey()
  final int audioSourceId;
  @override
  @JsonKey()
  final int audioCueStartId;
  @override
  @JsonKey()
  final int audioCueEndId;

  @override
  String toString() {
    return 'AudioBlockState(idInfo: $idInfo, offset: $offset, audioSourceId: $audioSourceId, audioCueStartId: $audioCueStartId, audioCueEndId: $audioCueEndId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioBlockStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.audioSourceId, audioSourceId) ||
                other.audioSourceId == audioSourceId) &&
            (identical(other.audioCueStartId, audioCueStartId) ||
                other.audioCueStartId == audioCueStartId) &&
            (identical(other.audioCueEndId, audioCueEndId) ||
                other.audioCueEndId == audioCueEndId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo, offset, audioSourceId,
      audioCueStartId, audioCueEndId);

  /// Create a copy of AudioBlockState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioBlockStateImplCopyWith<_$AudioBlockStateImpl> get copyWith =>
      __$$AudioBlockStateImplCopyWithImpl<_$AudioBlockStateImpl>(
          this, _$identity);
}

abstract class _AudioBlockState extends AudioBlockState {
  factory _AudioBlockState(
      {required final Id idInfo,
      required final Offset offset,
      final int audioSourceId,
      final int audioCueStartId,
      final int audioCueEndId}) = _$AudioBlockStateImpl;
  _AudioBlockState._() : super._();

  @override
  Id get idInfo;
  @override
  Offset get offset;
  @override
  int get audioSourceId;
  @override
  int get audioCueStartId;
  @override
  int get audioCueEndId;

  /// Create a copy of AudioBlockState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioBlockStateImplCopyWith<_$AudioBlockStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
