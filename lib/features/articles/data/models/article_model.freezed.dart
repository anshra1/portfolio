// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleModel {

 String get id; ArticleDisplayTier get displayTier; DateTime get publishedAt; String get title; String get readTime; String get summary; String get contentPath; List<String> get tags; String get coverImageAsset; String? get content;
/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleModelCopyWith<ArticleModel> get copyWith => _$ArticleModelCopyWithImpl<ArticleModel>(this as ArticleModel, _$identity);

  /// Serializes this ArticleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayTier, displayTier) || other.displayTier == displayTier)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.readTime, readTime) || other.readTime == readTime)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.contentPath, contentPath) || other.contentPath == contentPath)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.coverImageAsset, coverImageAsset) || other.coverImageAsset == coverImageAsset)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayTier,publishedAt,title,readTime,summary,contentPath,const DeepCollectionEquality().hash(tags),coverImageAsset,content);

@override
String toString() {
  return 'ArticleModel(id: $id, displayTier: $displayTier, publishedAt: $publishedAt, title: $title, readTime: $readTime, summary: $summary, contentPath: $contentPath, tags: $tags, coverImageAsset: $coverImageAsset, content: $content)';
}


}

/// @nodoc
abstract mixin class $ArticleModelCopyWith<$Res>  {
  factory $ArticleModelCopyWith(ArticleModel value, $Res Function(ArticleModel) _then) = _$ArticleModelCopyWithImpl;
@useResult
$Res call({
 String id, ArticleDisplayTier displayTier, DateTime publishedAt, String title, String readTime, String summary, String contentPath, List<String> tags, String coverImageAsset, String? content
});




}
/// @nodoc
class _$ArticleModelCopyWithImpl<$Res>
    implements $ArticleModelCopyWith<$Res> {
  _$ArticleModelCopyWithImpl(this._self, this._then);

  final ArticleModel _self;
  final $Res Function(ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayTier = null,Object? publishedAt = null,Object? title = null,Object? readTime = null,Object? summary = null,Object? contentPath = null,Object? tags = null,Object? coverImageAsset = null,Object? content = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayTier: null == displayTier ? _self.displayTier : displayTier // ignore: cast_nullable_to_non_nullable
as ArticleDisplayTier,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,readTime: null == readTime ? _self.readTime : readTime // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,contentPath: null == contentPath ? _self.contentPath : contentPath // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImageAsset: null == coverImageAsset ? _self.coverImageAsset : coverImageAsset // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleModel].
extension ArticleModelPatterns on ArticleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleModel value)  $default,){
final _that = this;
switch (_that) {
case _ArticleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleModel value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ArticleDisplayTier displayTier,  DateTime publishedAt,  String title,  String readTime,  String summary,  String contentPath,  List<String> tags,  String coverImageAsset,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
return $default(_that.id,_that.displayTier,_that.publishedAt,_that.title,_that.readTime,_that.summary,_that.contentPath,_that.tags,_that.coverImageAsset,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ArticleDisplayTier displayTier,  DateTime publishedAt,  String title,  String readTime,  String summary,  String contentPath,  List<String> tags,  String coverImageAsset,  String? content)  $default,) {final _that = this;
switch (_that) {
case _ArticleModel():
return $default(_that.id,_that.displayTier,_that.publishedAt,_that.title,_that.readTime,_that.summary,_that.contentPath,_that.tags,_that.coverImageAsset,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ArticleDisplayTier displayTier,  DateTime publishedAt,  String title,  String readTime,  String summary,  String contentPath,  List<String> tags,  String coverImageAsset,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
return $default(_that.id,_that.displayTier,_that.publishedAt,_that.title,_that.readTime,_that.summary,_that.contentPath,_that.tags,_that.coverImageAsset,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleModel extends ArticleModel {
  const _ArticleModel({required this.id, required this.displayTier, required this.publishedAt, required this.title, required this.readTime, required this.summary, required this.contentPath, required final  List<String> tags, required this.coverImageAsset, this.content}): _tags = tags,super._();
  factory _ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

@override final  String id;
@override final  ArticleDisplayTier displayTier;
@override final  DateTime publishedAt;
@override final  String title;
@override final  String readTime;
@override final  String summary;
@override final  String contentPath;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String coverImageAsset;
@override final  String? content;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleModelCopyWith<_ArticleModel> get copyWith => __$ArticleModelCopyWithImpl<_ArticleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayTier, displayTier) || other.displayTier == displayTier)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.readTime, readTime) || other.readTime == readTime)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.contentPath, contentPath) || other.contentPath == contentPath)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.coverImageAsset, coverImageAsset) || other.coverImageAsset == coverImageAsset)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayTier,publishedAt,title,readTime,summary,contentPath,const DeepCollectionEquality().hash(_tags),coverImageAsset,content);

@override
String toString() {
  return 'ArticleModel(id: $id, displayTier: $displayTier, publishedAt: $publishedAt, title: $title, readTime: $readTime, summary: $summary, contentPath: $contentPath, tags: $tags, coverImageAsset: $coverImageAsset, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ArticleModelCopyWith<$Res> implements $ArticleModelCopyWith<$Res> {
  factory _$ArticleModelCopyWith(_ArticleModel value, $Res Function(_ArticleModel) _then) = __$ArticleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, ArticleDisplayTier displayTier, DateTime publishedAt, String title, String readTime, String summary, String contentPath, List<String> tags, String coverImageAsset, String? content
});




}
/// @nodoc
class __$ArticleModelCopyWithImpl<$Res>
    implements _$ArticleModelCopyWith<$Res> {
  __$ArticleModelCopyWithImpl(this._self, this._then);

  final _ArticleModel _self;
  final $Res Function(_ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayTier = null,Object? publishedAt = null,Object? title = null,Object? readTime = null,Object? summary = null,Object? contentPath = null,Object? tags = null,Object? coverImageAsset = null,Object? content = freezed,}) {
  return _then(_ArticleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayTier: null == displayTier ? _self.displayTier : displayTier // ignore: cast_nullable_to_non_nullable
as ArticleDisplayTier,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,readTime: null == readTime ? _self.readTime : readTime // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,contentPath: null == contentPath ? _self.contentPath : contentPath // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImageAsset: null == coverImageAsset ? _self.coverImageAsset : coverImageAsset // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
