// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimelineState {
  Id get idInfo => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<TimelineGroupCubit> get timelineGroupList =>
      throw _privateConstructorUsedError;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineStateCopyWith<TimelineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineStateCopyWith<$Res> {
  factory $TimelineStateCopyWith(
          TimelineState value, $Res Function(TimelineState) then) =
      _$TimelineStateCopyWithImpl<$Res, TimelineState>;
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      String name,
      List<TimelineGroupCubit> timelineGroupList});
}

/// @nodoc
class _$TimelineStateCopyWithImpl<$Res, $Val extends TimelineState>
    implements $TimelineStateCopyWith<$Res> {
  _$TimelineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? name = null,
    Object? timelineGroupList = null,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      timelineGroupList: null == timelineGroupList
          ? _value.timelineGroupList
          : timelineGroupList // ignore: cast_nullable_to_non_nullable
              as List<TimelineGroupCubit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineStateImplCopyWith<$Res>
    implements $TimelineStateCopyWith<$Res> {
  factory _$$TimelineStateImplCopyWith(
          _$TimelineStateImpl value, $Res Function(_$TimelineStateImpl) then) =
      __$$TimelineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      String name,
      List<TimelineGroupCubit> timelineGroupList});
}

/// @nodoc
class __$$TimelineStateImplCopyWithImpl<$Res>
    extends _$TimelineStateCopyWithImpl<$Res, _$TimelineStateImpl>
    implements _$$TimelineStateImplCopyWith<$Res> {
  __$$TimelineStateImplCopyWithImpl(
      _$TimelineStateImpl _value, $Res Function(_$TimelineStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? name = null,
    Object? timelineGroupList = null,
  }) {
    return _then(_$TimelineStateImpl(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      timelineGroupList: null == timelineGroupList
          ? _value._timelineGroupList
          : timelineGroupList // ignore: cast_nullable_to_non_nullable
              as List<TimelineGroupCubit>,
    ));
  }
}

/// @nodoc

class _$TimelineStateImpl extends _TimelineState {
  _$TimelineStateImpl(
      {required this.idInfo,
      required this.offset,
      this.name = "타임라인 이름",
      final List<TimelineGroupCubit> timelineGroupList = const []})
      : _timelineGroupList = timelineGroupList,
        super._();

  @override
  final Id idInfo;
  @override
  final Offset offset;
  @override
  @JsonKey()
  final String name;
  final List<TimelineGroupCubit> _timelineGroupList;
  @override
  @JsonKey()
  List<TimelineGroupCubit> get timelineGroupList {
    if (_timelineGroupList is EqualUnmodifiableListView)
      return _timelineGroupList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timelineGroupList);
  }

  @override
  String toString() {
    return 'TimelineState(idInfo: $idInfo, offset: $offset, name: $name, timelineGroupList: $timelineGroupList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._timelineGroupList, _timelineGroupList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo, offset, name,
      const DeepCollectionEquality().hash(_timelineGroupList));

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineStateImplCopyWith<_$TimelineStateImpl> get copyWith =>
      __$$TimelineStateImplCopyWithImpl<_$TimelineStateImpl>(this, _$identity);
}

abstract class _TimelineState extends TimelineState {
  factory _TimelineState(
      {required final Id idInfo,
      required final Offset offset,
      final String name,
      final List<TimelineGroupCubit> timelineGroupList}) = _$TimelineStateImpl;
  _TimelineState._() : super._();

  @override
  Id get idInfo;
  @override
  Offset get offset;
  @override
  String get name;
  @override
  List<TimelineGroupCubit> get timelineGroupList;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineStateImplCopyWith<_$TimelineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
