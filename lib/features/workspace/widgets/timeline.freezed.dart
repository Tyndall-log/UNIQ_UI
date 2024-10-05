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
  List<int> get timeLineGroup => throw _privateConstructorUsedError;

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
  $Res call({Id idInfo, Offset offset, String name, List<int> timeLineGroup});
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
    Object? timeLineGroup = null,
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
      timeLineGroup: null == timeLineGroup
          ? _value.timeLineGroup
          : timeLineGroup // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeLineStateImplCopyWith<$Res>
    implements $TimelineStateCopyWith<$Res> {
  factory _$$TimeLineStateImplCopyWith(
          _$TimeLineStateImpl value, $Res Function(_$TimeLineStateImpl) then) =
      __$$TimeLineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Id idInfo, Offset offset, String name, List<int> timeLineGroup});
}

/// @nodoc
class __$$TimeLineStateImplCopyWithImpl<$Res>
    extends _$TimelineStateCopyWithImpl<$Res, _$TimeLineStateImpl>
    implements _$$TimeLineStateImplCopyWith<$Res> {
  __$$TimeLineStateImplCopyWithImpl(
      _$TimeLineStateImpl _value, $Res Function(_$TimeLineStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? name = null,
    Object? timeLineGroup = null,
  }) {
    return _then(_$TimeLineStateImpl(
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
      timeLineGroup: null == timeLineGroup
          ? _value._timeLineGroup
          : timeLineGroup // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$TimeLineStateImpl extends _TimeLineState {
  _$TimeLineStateImpl(
      {required this.idInfo,
      required this.offset,
      this.name = "타임라인 이름",
      final List<int> timeLineGroup = const []})
      : _timeLineGroup = timeLineGroup,
        super._();

  @override
  final Id idInfo;
  @override
  final Offset offset;
  @override
  @JsonKey()
  final String name;
  final List<int> _timeLineGroup;
  @override
  @JsonKey()
  List<int> get timeLineGroup {
    if (_timeLineGroup is EqualUnmodifiableListView) return _timeLineGroup;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeLineGroup);
  }

  @override
  String toString() {
    return 'TimelineState(idInfo: $idInfo, offset: $offset, name: $name, timeLineGroup: $timeLineGroup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeLineStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._timeLineGroup, _timeLineGroup));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo, offset, name,
      const DeepCollectionEquality().hash(_timeLineGroup));

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeLineStateImplCopyWith<_$TimeLineStateImpl> get copyWith =>
      __$$TimeLineStateImplCopyWithImpl<_$TimeLineStateImpl>(this, _$identity);
}

abstract class _TimeLineState extends TimelineState {
  factory _TimeLineState(
      {required final Id idInfo,
      required final Offset offset,
      final String name,
      final List<int> timeLineGroup}) = _$TimeLineStateImpl;
  _TimeLineState._() : super._();

  @override
  Id get idInfo;
  @override
  Offset get offset;
  @override
  String get name;
  @override
  List<int> get timeLineGroup;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeLineStateImplCopyWith<_$TimeLineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
