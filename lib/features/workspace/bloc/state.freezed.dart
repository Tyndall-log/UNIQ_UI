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
