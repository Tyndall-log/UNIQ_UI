// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectState {
  Id get idInfo => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get producerName =>
      throw _privateConstructorUsedError; // @Default([]) List<int> timeLine,
  List<TimelineCubit> get timeLineList => throw _privateConstructorUsedError;

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectStateCopyWith<ProjectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectStateCopyWith<$Res> {
  factory $ProjectStateCopyWith(
          ProjectState value, $Res Function(ProjectState) then) =
      _$ProjectStateCopyWithImpl<$Res, ProjectState>;
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      String title,
      String producerName,
      List<TimelineCubit> timeLineList});
}

/// @nodoc
class _$ProjectStateCopyWithImpl<$Res, $Val extends ProjectState>
    implements $ProjectStateCopyWith<$Res> {
  _$ProjectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? title = null,
    Object? producerName = null,
    Object? timeLineList = null,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      producerName: null == producerName
          ? _value.producerName
          : producerName // ignore: cast_nullable_to_non_nullable
              as String,
      timeLineList: null == timeLineList
          ? _value.timeLineList
          : timeLineList // ignore: cast_nullable_to_non_nullable
              as List<TimelineCubit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectStateImplCopyWith<$Res>
    implements $ProjectStateCopyWith<$Res> {
  factory _$$ProjectStateImplCopyWith(
          _$ProjectStateImpl value, $Res Function(_$ProjectStateImpl) then) =
      __$$ProjectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Id idInfo,
      Offset offset,
      String title,
      String producerName,
      List<TimelineCubit> timeLineList});
}

/// @nodoc
class __$$ProjectStateImplCopyWithImpl<$Res>
    extends _$ProjectStateCopyWithImpl<$Res, _$ProjectStateImpl>
    implements _$$ProjectStateImplCopyWith<$Res> {
  __$$ProjectStateImplCopyWithImpl(
      _$ProjectStateImpl _value, $Res Function(_$ProjectStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idInfo = null,
    Object? offset = null,
    Object? title = null,
    Object? producerName = null,
    Object? timeLineList = null,
  }) {
    return _then(_$ProjectStateImpl(
      idInfo: null == idInfo
          ? _value.idInfo
          : idInfo // ignore: cast_nullable_to_non_nullable
              as Id,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      producerName: null == producerName
          ? _value.producerName
          : producerName // ignore: cast_nullable_to_non_nullable
              as String,
      timeLineList: null == timeLineList
          ? _value._timeLineList
          : timeLineList // ignore: cast_nullable_to_non_nullable
              as List<TimelineCubit>,
    ));
  }
}

/// @nodoc

class _$ProjectStateImpl extends _ProjectState {
  _$ProjectStateImpl(
      {required this.idInfo,
      required this.offset,
      this.title = "새 프로젝트",
      this.producerName = "제작자 이름",
      final List<TimelineCubit> timeLineList = const []})
      : _timeLineList = timeLineList,
        super._();

  @override
  final Id idInfo;
  @override
  final Offset offset;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String producerName;
// @Default([]) List<int> timeLine,
  final List<TimelineCubit> _timeLineList;
// @Default([]) List<int> timeLine,
  @override
  @JsonKey()
  List<TimelineCubit> get timeLineList {
    if (_timeLineList is EqualUnmodifiableListView) return _timeLineList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeLineList);
  }

  @override
  String toString() {
    return 'ProjectState(idInfo: $idInfo, offset: $offset, title: $title, producerName: $producerName, timeLineList: $timeLineList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectStateImpl &&
            (identical(other.idInfo, idInfo) || other.idInfo == idInfo) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.producerName, producerName) ||
                other.producerName == producerName) &&
            const DeepCollectionEquality()
                .equals(other._timeLineList, _timeLineList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idInfo, offset, title,
      producerName, const DeepCollectionEquality().hash(_timeLineList));

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectStateImplCopyWith<_$ProjectStateImpl> get copyWith =>
      __$$ProjectStateImplCopyWithImpl<_$ProjectStateImpl>(this, _$identity);
}

abstract class _ProjectState extends ProjectState {
  factory _ProjectState(
      {required final Id idInfo,
      required final Offset offset,
      final String title,
      final String producerName,
      final List<TimelineCubit> timeLineList}) = _$ProjectStateImpl;
  _ProjectState._() : super._();

  @override
  Id get idInfo;
  @override
  Offset get offset;
  @override
  String get title;
  @override
  String get producerName; // @Default([]) List<int> timeLine,
  @override
  List<TimelineCubit> get timeLineList;

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectStateImplCopyWith<_$ProjectStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
