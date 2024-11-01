// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_cue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioCueState {
  Id get idInfo => throw _privateConstructorUsedError;
  List<void Function()> get callbackList => throw _privateConstructorUsedError;
  int get point => throw _privateConstructorUsedError;

  /// Create a copy of AudioCueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioCueStateCopyWith<AudioCueState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioCueStateCopyWith<$Res> {
  factory $AudioCueStateCopyWith(
          AudioCueState value, $Res Function(AudioCueState) then) =
      _$AudioCueStateCopyWithImpl<$Res, AudioCueState>;
  @useResult
  $Res call({Id idInfo, List<void Function()> callbackList, int point});
}

/// @nodoc
class _$AudioCueStateCopyWithImpl<$Res, $Val extends AudioCueState>
    implements $AudioCueStateCopyWith<$Res> {
  _$AudioCueStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioCueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? callbackList = null,
    Object? point = null,
  }) {
    return _then(_value.copyWith(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      callbackList: null == callbackList
          ? _value.callbackList
          : callbackList // ignore: cast_nullable_to_non_nullable
              as List<void Function()>,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineCueStateImplCopyWith<$Res>
    implements $AudioCueStateCopyWith<$Res> {
  factory _$$TimelineCueStateImplCopyWith(_$TimelineCueStateImpl value,
          $Res Function(_$TimelineCueStateImpl) then) =
      __$$TimelineCueStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Id idInfo, List<void Function()> callbackList, int point});
}

/// @nodoc
class __$$TimelineCueStateImplCopyWithImpl<$Res>
    extends _$AudioCueStateCopyWithImpl<$Res, _$TimelineCueStateImpl>
    implements _$$TimelineCueStateImplCopyWith<$Res> {
  __$$TimelineCueStateImplCopyWithImpl(_$TimelineCueStateImpl _value,
      $Res Function(_$TimelineCueStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioCueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? callbackList = null,
    Object? point = null,
  }) {
    return _then(_$TimelineCueStateImpl(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      callbackList: null == callbackList
          ? _value._callbackList
          : callbackList // ignore: cast_nullable_to_non_nullable
              as List<void Function()>,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TimelineCueStateImpl extends _TimelineCueState {
  _$TimelineCueStateImpl(
      {required this.idInfo,
      final List<void Function()> callbackList = const [],
      this.point = 0})
      : _callbackList = callbackList,
        super._();

  @override
  final Id idInfo;
  final List<void Function()> _callbackList;
  @override
  @JsonKey()
  List<void Function()> get callbackList {
    if (_callbackList is EqualUnmodifiableListView) return _callbackList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_callbackList);
  }

  @override
  @JsonKey()
  final int point;

  @override
  String toString() {
    return 'AudioCueState(idInfo: $idInfo, callbackList: $callbackList, point: $point)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineCueStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            const DeepCollectionEquality()
                .equals(other._callbackList, _callbackList) &&
            (identical(other.point, point) || other.point == point));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo,
      const DeepCollectionEquality().hash(_callbackList), point);

  /// Create a copy of AudioCueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineCueStateImplCopyWith<_$TimelineCueStateImpl> get copyWith =>
      __$$TimelineCueStateImplCopyWithImpl<_$TimelineCueStateImpl>(
          this, _$identity);
}

abstract class _TimelineCueState extends AudioCueState {
  factory _TimelineCueState(
      {required final Id idInfo,
      final List<void Function()> callbackList,
      final int point}) = _$TimelineCueStateImpl;
  _TimelineCueState._() : super._();

  @override
  Id get idInfo;
  @override
  List<void Function()> get callbackList;
  @override
  int get point;

  /// Create a copy of AudioCueState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineCueStateImplCopyWith<_$TimelineCueStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
