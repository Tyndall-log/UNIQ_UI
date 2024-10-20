// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkspaceProjectManagerState {
  int get workspaceId => throw _privateConstructorUsedError;
  List<ProjectCubit> get projects => throw _privateConstructorUsedError;

  /// Create a copy of WorkspaceProjectManagerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkspaceProjectManagerStateCopyWith<WorkspaceProjectManagerState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkspaceProjectManagerStateCopyWith<$Res> {
  factory $WorkspaceProjectManagerStateCopyWith(
          WorkspaceProjectManagerState value,
          $Res Function(WorkspaceProjectManagerState) then) =
      _$WorkspaceProjectManagerStateCopyWithImpl<$Res,
          WorkspaceProjectManagerState>;
  @useResult
  $Res call({int workspaceId, List<ProjectCubit> projects});
}

/// @nodoc
class _$WorkspaceProjectManagerStateCopyWithImpl<$Res,
        $Val extends WorkspaceProjectManagerState>
    implements $WorkspaceProjectManagerStateCopyWith<$Res> {
  _$WorkspaceProjectManagerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkspaceProjectManagerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceId = null,
    Object? projects = null,
  }) {
    return _then(_value.copyWith(
      workspaceId: null == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as int,
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<ProjectCubit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkspaceProjectManagerStateImplCopyWith<$Res>
    implements $WorkspaceProjectManagerStateCopyWith<$Res> {
  factory _$$WorkspaceProjectManagerStateImplCopyWith(
          _$WorkspaceProjectManagerStateImpl value,
          $Res Function(_$WorkspaceProjectManagerStateImpl) then) =
      __$$WorkspaceProjectManagerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int workspaceId, List<ProjectCubit> projects});
}

/// @nodoc
class __$$WorkspaceProjectManagerStateImplCopyWithImpl<$Res>
    extends _$WorkspaceProjectManagerStateCopyWithImpl<$Res,
        _$WorkspaceProjectManagerStateImpl>
    implements _$$WorkspaceProjectManagerStateImplCopyWith<$Res> {
  __$$WorkspaceProjectManagerStateImplCopyWithImpl(
      _$WorkspaceProjectManagerStateImpl _value,
      $Res Function(_$WorkspaceProjectManagerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceProjectManagerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceId = null,
    Object? projects = null,
  }) {
    return _then(_$WorkspaceProjectManagerStateImpl(
      workspaceId: null == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as int,
      projects: null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<ProjectCubit>,
    ));
  }
}

/// @nodoc

class _$WorkspaceProjectManagerStateImpl extends _WorkspaceProjectManagerState {
  _$WorkspaceProjectManagerStateImpl(
      {required this.workspaceId, final List<ProjectCubit> projects = const []})
      : _projects = projects,
        super._();

  @override
  final int workspaceId;
  final List<ProjectCubit> _projects;
  @override
  @JsonKey()
  List<ProjectCubit> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  String toString() {
    return 'WorkspaceProjectManagerState(workspaceId: $workspaceId, projects: $projects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkspaceProjectManagerStateImpl &&
            (identical(other.workspaceId, workspaceId) ||
                other.workspaceId == workspaceId) &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, workspaceId, const DeepCollectionEquality().hash(_projects));

  /// Create a copy of WorkspaceProjectManagerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkspaceProjectManagerStateImplCopyWith<
          _$WorkspaceProjectManagerStateImpl>
      get copyWith => __$$WorkspaceProjectManagerStateImplCopyWithImpl<
          _$WorkspaceProjectManagerStateImpl>(this, _$identity);
}

abstract class _WorkspaceProjectManagerState
    extends WorkspaceProjectManagerState {
  factory _WorkspaceProjectManagerState(
      {required final int workspaceId,
      final List<ProjectCubit> projects}) = _$WorkspaceProjectManagerStateImpl;
  _WorkspaceProjectManagerState._() : super._();

  @override
  int get workspaceId;
  @override
  List<ProjectCubit> get projects;

  /// Create a copy of WorkspaceProjectManagerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkspaceProjectManagerStateImplCopyWith<
          _$WorkspaceProjectManagerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkspaceWidgetManagerState {
  int get workspaceId => throw _privateConstructorUsedError;
  Map<int, WorkspaceWidgetManagerPair> get widgets =>
      throw _privateConstructorUsedError;
  Map<Type, List<WorkspaceWidgetManagerPair>> get objects =>
      throw _privateConstructorUsedError;

  /// Create a copy of WorkspaceWidgetManagerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkspaceWidgetManagerStateCopyWith<WorkspaceWidgetManagerState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkspaceWidgetManagerStateCopyWith<$Res> {
  factory $WorkspaceWidgetManagerStateCopyWith(
          WorkspaceWidgetManagerState value,
          $Res Function(WorkspaceWidgetManagerState) then) =
      _$WorkspaceWidgetManagerStateCopyWithImpl<$Res,
          WorkspaceWidgetManagerState>;
  @useResult
  $Res call(
      {int workspaceId,
      Map<int, WorkspaceWidgetManagerPair> widgets,
      Map<Type, List<WorkspaceWidgetManagerPair>> objects});
}

/// @nodoc
class _$WorkspaceWidgetManagerStateCopyWithImpl<$Res,
        $Val extends WorkspaceWidgetManagerState>
    implements $WorkspaceWidgetManagerStateCopyWith<$Res> {
  _$WorkspaceWidgetManagerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkspaceWidgetManagerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceId = null,
    Object? widgets = null,
    Object? objects = null,
  }) {
    return _then(_value.copyWith(
      workspaceId: null == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as int,
      widgets: null == widgets
          ? _value.widgets
          : widgets // ignore: cast_nullable_to_non_nullable
              as Map<int, WorkspaceWidgetManagerPair>,
      objects: null == objects
          ? _value.objects
          : objects // ignore: cast_nullable_to_non_nullable
              as Map<Type, List<WorkspaceWidgetManagerPair>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkspaceWidgetManagerStateImplCopyWith<$Res>
    implements $WorkspaceWidgetManagerStateCopyWith<$Res> {
  factory _$$WorkspaceWidgetManagerStateImplCopyWith(
          _$WorkspaceWidgetManagerStateImpl value,
          $Res Function(_$WorkspaceWidgetManagerStateImpl) then) =
      __$$WorkspaceWidgetManagerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int workspaceId,
      Map<int, WorkspaceWidgetManagerPair> widgets,
      Map<Type, List<WorkspaceWidgetManagerPair>> objects});
}

/// @nodoc
class __$$WorkspaceWidgetManagerStateImplCopyWithImpl<$Res>
    extends _$WorkspaceWidgetManagerStateCopyWithImpl<$Res,
        _$WorkspaceWidgetManagerStateImpl>
    implements _$$WorkspaceWidgetManagerStateImplCopyWith<$Res> {
  __$$WorkspaceWidgetManagerStateImplCopyWithImpl(
      _$WorkspaceWidgetManagerStateImpl _value,
      $Res Function(_$WorkspaceWidgetManagerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceWidgetManagerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceId = null,
    Object? widgets = null,
    Object? objects = null,
  }) {
    return _then(_$WorkspaceWidgetManagerStateImpl(
      workspaceId: null == workspaceId
          ? _value.workspaceId
          : workspaceId // ignore: cast_nullable_to_non_nullable
              as int,
      widgets: null == widgets
          ? _value._widgets
          : widgets // ignore: cast_nullable_to_non_nullable
              as Map<int, WorkspaceWidgetManagerPair>,
      objects: null == objects
          ? _value._objects
          : objects // ignore: cast_nullable_to_non_nullable
              as Map<Type, List<WorkspaceWidgetManagerPair>>,
    ));
  }
}

/// @nodoc

class _$WorkspaceWidgetManagerStateImpl extends _WorkspaceWidgetManagerState {
  _$WorkspaceWidgetManagerStateImpl(
      {required this.workspaceId,
      final Map<int, WorkspaceWidgetManagerPair> widgets = const {},
      final Map<Type, List<WorkspaceWidgetManagerPair>> objects = const {}})
      : _widgets = widgets,
        _objects = objects,
        super._();

  @override
  final int workspaceId;
  final Map<int, WorkspaceWidgetManagerPair> _widgets;
  @override
  @JsonKey()
  Map<int, WorkspaceWidgetManagerPair> get widgets {
    if (_widgets is EqualUnmodifiableMapView) return _widgets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_widgets);
  }

  final Map<Type, List<WorkspaceWidgetManagerPair>> _objects;
  @override
  @JsonKey()
  Map<Type, List<WorkspaceWidgetManagerPair>> get objects {
    if (_objects is EqualUnmodifiableMapView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_objects);
  }

  @override
  String toString() {
    return 'WorkspaceWidgetManagerState(workspaceId: $workspaceId, widgets: $widgets, objects: $objects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkspaceWidgetManagerStateImpl &&
            (identical(other.workspaceId, workspaceId) ||
                other.workspaceId == workspaceId) &&
            const DeepCollectionEquality().equals(other._widgets, _widgets) &&
            const DeepCollectionEquality().equals(other._objects, _objects));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      workspaceId,
      const DeepCollectionEquality().hash(_widgets),
      const DeepCollectionEquality().hash(_objects));

  /// Create a copy of WorkspaceWidgetManagerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkspaceWidgetManagerStateImplCopyWith<_$WorkspaceWidgetManagerStateImpl>
      get copyWith => __$$WorkspaceWidgetManagerStateImplCopyWithImpl<
          _$WorkspaceWidgetManagerStateImpl>(this, _$identity);
}

abstract class _WorkspaceWidgetManagerState
    extends WorkspaceWidgetManagerState {
  factory _WorkspaceWidgetManagerState(
          {required final int workspaceId,
          final Map<int, WorkspaceWidgetManagerPair> widgets,
          final Map<Type, List<WorkspaceWidgetManagerPair>> objects}) =
      _$WorkspaceWidgetManagerStateImpl;
  _WorkspaceWidgetManagerState._() : super._();

  @override
  int get workspaceId;
  @override
  Map<int, WorkspaceWidgetManagerPair> get widgets;
  @override
  Map<Type, List<WorkspaceWidgetManagerPair>> get objects;

  /// Create a copy of WorkspaceWidgetManagerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkspaceWidgetManagerStateImplCopyWith<_$WorkspaceWidgetManagerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
