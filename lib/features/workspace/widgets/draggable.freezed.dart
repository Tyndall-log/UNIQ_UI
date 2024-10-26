// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draggable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkspaceDragState<T> {
  T get cubit => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;
  Size get size => throw _privateConstructorUsedError;

  /// Create a copy of WorkspaceDragState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkspaceDragStateCopyWith<T, WorkspaceDragState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkspaceDragStateCopyWith<T, $Res> {
  factory $WorkspaceDragStateCopyWith(WorkspaceDragState<T> value,
          $Res Function(WorkspaceDragState<T>) then) =
      _$WorkspaceDragStateCopyWithImpl<T, $Res, WorkspaceDragState<T>>;
  @useResult
  $Res call({T cubit, Offset offset, Size size});
}

/// @nodoc
class _$WorkspaceDragStateCopyWithImpl<T, $Res,
        $Val extends WorkspaceDragState<T>>
    implements $WorkspaceDragStateCopyWith<T, $Res> {
  _$WorkspaceDragStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkspaceDragState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cubit = freezed,
    Object? offset = null,
    Object? size = null,
  }) {
    return _then(_value.copyWith(
      cubit: freezed == cubit
          ? _value.cubit
          : cubit // ignore: cast_nullable_to_non_nullable
              as T,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkspaceDragStateImplCopyWith<T, $Res>
    implements $WorkspaceDragStateCopyWith<T, $Res> {
  factory _$$WorkspaceDragStateImplCopyWith(_$WorkspaceDragStateImpl<T> value,
          $Res Function(_$WorkspaceDragStateImpl<T>) then) =
      __$$WorkspaceDragStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T cubit, Offset offset, Size size});
}

/// @nodoc
class __$$WorkspaceDragStateImplCopyWithImpl<T, $Res>
    extends _$WorkspaceDragStateCopyWithImpl<T, $Res,
        _$WorkspaceDragStateImpl<T>>
    implements _$$WorkspaceDragStateImplCopyWith<T, $Res> {
  __$$WorkspaceDragStateImplCopyWithImpl(_$WorkspaceDragStateImpl<T> _value,
      $Res Function(_$WorkspaceDragStateImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceDragState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cubit = freezed,
    Object? offset = null,
    Object? size = null,
  }) {
    return _then(_$WorkspaceDragStateImpl<T>(
      cubit: freezed == cubit
          ? _value.cubit
          : cubit // ignore: cast_nullable_to_non_nullable
              as T,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
    ));
  }
}

/// @nodoc

class _$WorkspaceDragStateImpl<T> extends _WorkspaceDragState<T> {
  _$WorkspaceDragStateImpl(
      {required this.cubit, required this.offset, required this.size})
      : super._();

  @override
  final T cubit;
  @override
  final Offset offset;
  @override
  final Size size;

  @override
  String toString() {
    return 'WorkspaceDragState<$T>(cubit: $cubit, offset: $offset, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkspaceDragStateImpl<T> &&
            const DeepCollectionEquality().equals(other.cubit, cubit) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.size, size) || other.size == size));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(cubit), offset, size);

  /// Create a copy of WorkspaceDragState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkspaceDragStateImplCopyWith<T, _$WorkspaceDragStateImpl<T>>
      get copyWith => __$$WorkspaceDragStateImplCopyWithImpl<T,
          _$WorkspaceDragStateImpl<T>>(this, _$identity);
}

abstract class _WorkspaceDragState<T> extends WorkspaceDragState<T> {
  factory _WorkspaceDragState(
      {required final T cubit,
      required final Offset offset,
      required final Size size}) = _$WorkspaceDragStateImpl<T>;
  _WorkspaceDragState._() : super._();

  @override
  T get cubit;
  @override
  Offset get offset;
  @override
  Size get size;

  /// Create a copy of WorkspaceDragState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkspaceDragStateImplCopyWith<T, _$WorkspaceDragStateImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
