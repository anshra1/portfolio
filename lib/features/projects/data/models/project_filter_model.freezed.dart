// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectFilterModel {

 String? get searchQuery; String? get technology; SortOrder? get sortOrder; bool? get isFeatured;
/// Create a copy of ProjectFilterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectFilterModelCopyWith<ProjectFilterModel> get copyWith => _$ProjectFilterModelCopyWithImpl<ProjectFilterModel>(this as ProjectFilterModel, _$identity);

  /// Serializes this ProjectFilterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectFilterModel&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.technology, technology) || other.technology == technology)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchQuery,technology,sortOrder,isFeatured);

@override
String toString() {
  return 'ProjectFilterModel(searchQuery: $searchQuery, technology: $technology, sortOrder: $sortOrder, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $ProjectFilterModelCopyWith<$Res>  {
  factory $ProjectFilterModelCopyWith(ProjectFilterModel value, $Res Function(ProjectFilterModel) _then) = _$ProjectFilterModelCopyWithImpl;
@useResult
$Res call({
 String? searchQuery, String? technology, SortOrder? sortOrder, bool? isFeatured
});




}
/// @nodoc
class _$ProjectFilterModelCopyWithImpl<$Res>
    implements $ProjectFilterModelCopyWith<$Res> {
  _$ProjectFilterModelCopyWithImpl(this._self, this._then);

  final ProjectFilterModel _self;
  final $Res Function(ProjectFilterModel) _then;

/// Create a copy of ProjectFilterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = freezed,Object? technology = freezed,Object? sortOrder = freezed,Object? isFeatured = freezed,}) {
  return _then(_self.copyWith(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,technology: freezed == technology ? _self.technology : technology // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectFilterModel].
extension ProjectFilterModelPatterns on ProjectFilterModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectFilterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectFilterModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectFilterModel value)  $default,){
final _that = this;
switch (_that) {
case _ProjectFilterModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectFilterModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectFilterModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? searchQuery,  String? technology,  SortOrder? sortOrder,  bool? isFeatured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectFilterModel() when $default != null:
return $default(_that.searchQuery,_that.technology,_that.sortOrder,_that.isFeatured);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? searchQuery,  String? technology,  SortOrder? sortOrder,  bool? isFeatured)  $default,) {final _that = this;
switch (_that) {
case _ProjectFilterModel():
return $default(_that.searchQuery,_that.technology,_that.sortOrder,_that.isFeatured);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? searchQuery,  String? technology,  SortOrder? sortOrder,  bool? isFeatured)?  $default,) {final _that = this;
switch (_that) {
case _ProjectFilterModel() when $default != null:
return $default(_that.searchQuery,_that.technology,_that.sortOrder,_that.isFeatured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectFilterModel extends ProjectFilterModel {
  const _ProjectFilterModel({this.searchQuery, this.technology, this.sortOrder, this.isFeatured}): super._();
  factory _ProjectFilterModel.fromJson(Map<String, dynamic> json) => _$ProjectFilterModelFromJson(json);

@override final  String? searchQuery;
@override final  String? technology;
@override final  SortOrder? sortOrder;
@override final  bool? isFeatured;

/// Create a copy of ProjectFilterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectFilterModelCopyWith<_ProjectFilterModel> get copyWith => __$ProjectFilterModelCopyWithImpl<_ProjectFilterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectFilterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectFilterModel&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.technology, technology) || other.technology == technology)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchQuery,technology,sortOrder,isFeatured);

@override
String toString() {
  return 'ProjectFilterModel(searchQuery: $searchQuery, technology: $technology, sortOrder: $sortOrder, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$ProjectFilterModelCopyWith<$Res> implements $ProjectFilterModelCopyWith<$Res> {
  factory _$ProjectFilterModelCopyWith(_ProjectFilterModel value, $Res Function(_ProjectFilterModel) _then) = __$ProjectFilterModelCopyWithImpl;
@override @useResult
$Res call({
 String? searchQuery, String? technology, SortOrder? sortOrder, bool? isFeatured
});




}
/// @nodoc
class __$ProjectFilterModelCopyWithImpl<$Res>
    implements _$ProjectFilterModelCopyWith<$Res> {
  __$ProjectFilterModelCopyWithImpl(this._self, this._then);

  final _ProjectFilterModel _self;
  final $Res Function(_ProjectFilterModel) _then;

/// Create a copy of ProjectFilterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = freezed,Object? technology = freezed,Object? sortOrder = freezed,Object? isFeatured = freezed,}) {
  return _then(_ProjectFilterModel(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,technology: freezed == technology ? _self.technology : technology // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
