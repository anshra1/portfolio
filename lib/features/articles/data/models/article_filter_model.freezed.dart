// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleFilterModel {

 String? get searchQuery; List<String> get tags; SortOrder? get sortOrder;
/// Create a copy of ArticleFilterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleFilterModelCopyWith<ArticleFilterModel> get copyWith => _$ArticleFilterModelCopyWithImpl<ArticleFilterModel>(this as ArticleFilterModel, _$identity);

  /// Serializes this ArticleFilterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleFilterModel&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchQuery,const DeepCollectionEquality().hash(tags),sortOrder);

@override
String toString() {
  return 'ArticleFilterModel(searchQuery: $searchQuery, tags: $tags, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ArticleFilterModelCopyWith<$Res>  {
  factory $ArticleFilterModelCopyWith(ArticleFilterModel value, $Res Function(ArticleFilterModel) _then) = _$ArticleFilterModelCopyWithImpl;
@useResult
$Res call({
 String? searchQuery, List<String> tags, SortOrder? sortOrder
});




}
/// @nodoc
class _$ArticleFilterModelCopyWithImpl<$Res>
    implements $ArticleFilterModelCopyWith<$Res> {
  _$ArticleFilterModelCopyWithImpl(this._self, this._then);

  final ArticleFilterModel _self;
  final $Res Function(ArticleFilterModel) _then;

/// Create a copy of ArticleFilterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = freezed,Object? tags = null,Object? sortOrder = freezed,}) {
  return _then(_self.copyWith(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleFilterModel].
extension ArticleFilterModelPatterns on ArticleFilterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleFilterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleFilterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleFilterModel value)  $default,){
final _that = this;
switch (_that) {
case _ArticleFilterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleFilterModel value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleFilterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? searchQuery,  List<String> tags,  SortOrder? sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleFilterModel() when $default != null:
return $default(_that.searchQuery,_that.tags,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? searchQuery,  List<String> tags,  SortOrder? sortOrder)  $default,) {final _that = this;
switch (_that) {
case _ArticleFilterModel():
return $default(_that.searchQuery,_that.tags,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? searchQuery,  List<String> tags,  SortOrder? sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _ArticleFilterModel() when $default != null:
return $default(_that.searchQuery,_that.tags,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleFilterModel extends ArticleFilterModel {
  const _ArticleFilterModel({this.searchQuery, final  List<String> tags = const [], this.sortOrder}): _tags = tags,super._();
  factory _ArticleFilterModel.fromJson(Map<String, dynamic> json) => _$ArticleFilterModelFromJson(json);

@override final  String? searchQuery;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  SortOrder? sortOrder;

/// Create a copy of ArticleFilterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleFilterModelCopyWith<_ArticleFilterModel> get copyWith => __$ArticleFilterModelCopyWithImpl<_ArticleFilterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleFilterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleFilterModel&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchQuery,const DeepCollectionEquality().hash(_tags),sortOrder);

@override
String toString() {
  return 'ArticleFilterModel(searchQuery: $searchQuery, tags: $tags, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ArticleFilterModelCopyWith<$Res> implements $ArticleFilterModelCopyWith<$Res> {
  factory _$ArticleFilterModelCopyWith(_ArticleFilterModel value, $Res Function(_ArticleFilterModel) _then) = __$ArticleFilterModelCopyWithImpl;
@override @useResult
$Res call({
 String? searchQuery, List<String> tags, SortOrder? sortOrder
});




}
/// @nodoc
class __$ArticleFilterModelCopyWithImpl<$Res>
    implements _$ArticleFilterModelCopyWith<$Res> {
  __$ArticleFilterModelCopyWithImpl(this._self, this._then);

  final _ArticleFilterModel _self;
  final $Res Function(_ArticleFilterModel) _then;

/// Create a copy of ArticleFilterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = freezed,Object? tags = null,Object? sortOrder = freezed,}) {
  return _then(_ArticleFilterModel(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder?,
  ));
}


}

// dart format on
