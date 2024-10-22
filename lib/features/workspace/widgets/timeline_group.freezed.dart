// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimelineGroupState {
  Id get idInfo => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;
  int get eventDuration =>
      throw _privateConstructorUsedError; // @Default([]) List<EventBlockCubit> eventList,
  List<AudioBlockCubit> get audioBlockList =>
      throw _privateConstructorUsedError;

  /// Create a copy of TimelineGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineGroupStateCopyWith<TimelineGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineGroupStateCopyWith<$Res> {
  factory $TimelineGroupStateCopyWith(
          TimelineGroupState value, $Res Function(TimelineGroupState) then) =
      _$TimelineGroupStateCopyWithImpl<$Res, TimelineGroupState>;
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      int eventDuration,
      List<AudioBlockCubit> audioBlockList});
}

/// @nodoc
class _$TimelineGroupStateCopyWithImpl<$Res, $Val extends TimelineGroupState>
    implements $TimelineGroupStateCopyWith<$Res> {
  _$TimelineGroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineGroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? eventDuration = null,
    Object? audioBlockList = null,
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
      eventDuration: null == eventDuration
          ? _value.eventDuration
          : eventDuration // ignore: cast_nullable_to_non_nullable
              as int,
      audioBlockList: null == audioBlockList
          ? _value.audioBlockList
          : audioBlockList // ignore: cast_nullable_to_non_nullable
              as List<AudioBlockCubit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineGroupStateImplCopyWith<$Res>
    implements $TimelineGroupStateCopyWith<$Res> {
  factory _$$TimelineGroupStateImplCopyWith(_$TimelineGroupStateImpl value,
          $Res Function(_$TimelineGroupStateImpl) then) =
      __$$TimelineGroupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      int eventDuration,
      List<AudioBlockCubit> audioBlockList});
}

/// @nodoc
class __$$TimelineGroupStateImplCopyWithImpl<$Res>
    extends _$TimelineGroupStateCopyWithImpl<$Res, _$TimelineGroupStateImpl>
    implements _$$TimelineGroupStateImplCopyWith<$Res> {
  __$$TimelineGroupStateImplCopyWithImpl(_$TimelineGroupStateImpl _value,
      $Res Function(_$TimelineGroupStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineGroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? eventDuration = null,
    Object? audioBlockList = null,
  }) {
    return _then(_$TimelineGroupStateImpl(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      eventDuration: null == eventDuration
          ? _value.eventDuration
          : eventDuration // ignore: cast_nullable_to_non_nullable
              as int,
      audioBlockList: null == audioBlockList
          ? _value._audioBlockList
          : audioBlockList // ignore: cast_nullable_to_non_nullable
              as List<AudioBlockCubit>,
    ));
  }
}

/// @nodoc

class _$TimelineGroupStateImpl extends _TimelineGroupState {
  _$TimelineGroupStateImpl(
      {required this.idInfo,
      required this.offset,
      this.eventDuration = 100 * 1000,
      final List<AudioBlockCubit> audioBlockList = const []})
      : _audioBlockList = audioBlockList,
        super._();

  @override
  final Id idInfo;
  @override
  final Offset offset;
  @override
  @JsonKey()
  final int eventDuration;
// @Default([]) List<EventBlockCubit> eventList,
  final List<AudioBlockCubit> _audioBlockList;
// @Default([]) List<EventBlockCubit> eventList,
  @override
  @JsonKey()
  List<AudioBlockCubit> get audioBlockList {
    if (_audioBlockList is EqualUnmodifiableListView) return _audioBlockList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audioBlockList);
  }

  @override
  String toString() {
    return 'TimelineGroupState(idInfo: $idInfo, offset: $offset, eventDuration: $eventDuration, audioBlockList: $audioBlockList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineGroupStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.eventDuration, eventDuration) ||
                other.eventDuration == eventDuration) &&
            const DeepCollectionEquality()
                .equals(other._audioBlockList, _audioBlockList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo, offset, eventDuration,
      const DeepCollectionEquality().hash(_audioBlockList));

  /// Create a copy of TimelineGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineGroupStateImplCopyWith<_$TimelineGroupStateImpl> get copyWith =>
      __$$TimelineGroupStateImplCopyWithImpl<_$TimelineGroupStateImpl>(
          this, _$identity);
}

abstract class _TimelineGroupState extends TimelineGroupState {
  factory _TimelineGroupState(
      {required final Id idInfo,
      required final Offset offset,
      final int eventDuration,
      final List<AudioBlockCubit> audioBlockList}) = _$TimelineGroupStateImpl;
  _TimelineGroupState._() : super._();

  @override
  Id get idInfo;
  @override
  Offset get offset;
  @override
  int get eventDuration; // @Default([]) List<EventBlockCubit> eventList,
  @override
  List<AudioBlockCubit> get audioBlockList;

  /// Create a copy of TimelineGroupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineGroupStateImplCopyWith<_$TimelineGroupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
