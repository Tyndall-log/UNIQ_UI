// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventBlockState {
  Id get idInfo => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;

  /// Create a copy of EventBlockState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventBlockStateCopyWith<EventBlockState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventBlockStateCopyWith<$Res> {
  factory $EventBlockStateCopyWith(
          EventBlockState value, $Res Function(EventBlockState) then) =
      _$EventBlockStateCopyWithImpl<$Res, EventBlockState>;
  @useResult
  $Res call({Id idInfo, Offset offset});
}

/// @nodoc
class _$EventBlockStateCopyWithImpl<$Res, $Val extends EventBlockState>
    implements $EventBlockStateCopyWith<$Res> {
  _$EventBlockStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventBlockState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventBlockStateImplCopyWith<$Res>
    implements $EventBlockStateCopyWith<$Res> {
  factory _$$EventBlockStateImplCopyWith(_$EventBlockStateImpl value,
          $Res Function(_$EventBlockStateImpl) then) =
      __$$EventBlockStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Id idInfo, Offset offset});
}

/// @nodoc
class __$$EventBlockStateImplCopyWithImpl<$Res>
    extends _$EventBlockStateCopyWithImpl<$Res, _$EventBlockStateImpl>
    implements _$$EventBlockStateImplCopyWith<$Res> {
  __$$EventBlockStateImplCopyWithImpl(
      _$EventBlockStateImpl _value, $Res Function(_$EventBlockStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventBlockState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
  }) {
    return _then(_$EventBlockStateImpl(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc

class _$EventBlockStateImpl extends _EventBlockState {
  _$EventBlockStateImpl({required this.idInfo, required this.offset})
      : super._();

  @override
  final Id idInfo;
  @override
  final Offset offset;

  @override
  String toString() {
    return 'EventBlockState(idInfo: $idInfo, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventBlockStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo, offset);

  /// Create a copy of EventBlockState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventBlockStateImplCopyWith<_$EventBlockStateImpl> get copyWith =>
      __$$EventBlockStateImplCopyWithImpl<_$EventBlockStateImpl>(
          this, _$identity);
}

abstract class _EventBlockState extends EventBlockState {
  factory _EventBlockState(
      {required final Id idInfo,
      required final Offset offset}) = _$EventBlockStateImpl;
  _EventBlockState._() : super._();

  @override
  Id get idInfo;
  @override
  Offset get offset;

  /// Create a copy of EventBlockState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventBlockStateImplCopyWith<_$EventBlockStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
