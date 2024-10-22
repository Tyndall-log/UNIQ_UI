// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioSourceState {
  Id get idInfo => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;
  int get sampleRate => throw _privateConstructorUsedError;

  /// Create a copy of AudioSourceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioSourceStateCopyWith<AudioSourceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioSourceStateCopyWith<$Res> {
  factory $AudioSourceStateCopyWith(
          AudioSourceState value, $Res Function(AudioSourceState) then) =
      _$AudioSourceStateCopyWithImpl<$Res, AudioSourceState>;
  @useResult
  $Res call({Id idInfo, Offset offset, int sampleRate});
}

/// @nodoc
class _$AudioSourceStateCopyWithImpl<$Res, $Val extends AudioSourceState>
    implements $AudioSourceStateCopyWith<$Res> {
  _$AudioSourceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioSourceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? sampleRate = null,
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
      sampleRate: null == sampleRate
          ? _value.sampleRate
          : sampleRate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioSourceStateImplCopyWith<$Res>
    implements $AudioSourceStateCopyWith<$Res> {
  factory _$$AudioSourceStateImplCopyWith(_$AudioSourceStateImpl value,
          $Res Function(_$AudioSourceStateImpl) then) =
      __$$AudioSourceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Id idInfo, Offset offset, int sampleRate});
}

/// @nodoc
class __$$AudioSourceStateImplCopyWithImpl<$Res>
    extends _$AudioSourceStateCopyWithImpl<$Res, _$AudioSourceStateImpl>
    implements _$$AudioSourceStateImplCopyWith<$Res> {
  __$$AudioSourceStateImplCopyWithImpl(_$AudioSourceStateImpl _value,
      $Res Function(_$AudioSourceStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioSourceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? sampleRate = null,
  }) {
    return _then(_$AudioSourceStateImpl(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      sampleRate: null == sampleRate
          ? _value.sampleRate
          : sampleRate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AudioSourceStateImpl extends _AudioSourceState {
  _$AudioSourceStateImpl(
      {required this.idInfo, required this.offset, this.sampleRate = 44100})
      : super._();

  @override
  final Id idInfo;
  @override
  final Offset offset;
  @override
  @JsonKey()
  final int sampleRate;

  @override
  String toString() {
    return 'AudioSourceState(idInfo: $idInfo, offset: $offset, sampleRate: $sampleRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioSourceStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.sampleRate, sampleRate) ||
                other.sampleRate == sampleRate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo, offset, sampleRate);

  /// Create a copy of AudioSourceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioSourceStateImplCopyWith<_$AudioSourceStateImpl> get copyWith =>
      __$$AudioSourceStateImplCopyWithImpl<_$AudioSourceStateImpl>(
          this, _$identity);
}

abstract class _AudioSourceState extends AudioSourceState {
  factory _AudioSourceState(
      {required final Id idInfo,
      required final Offset offset,
      final int sampleRate}) = _$AudioSourceStateImpl;
  _AudioSourceState._() : super._();

  @override
  Id get idInfo;
  @override
  Offset get offset;
  @override
  int get sampleRate;

  /// Create a copy of AudioSourceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioSourceStateImplCopyWith<_$AudioSourceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
