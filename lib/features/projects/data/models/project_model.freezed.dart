// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectModel {

 String get id; DisplayTier get displayTier; DateTime get publishedAt; String get title; String get tagline; String get typeIcon; String get coverImageAsset; String get sourceUrl; String get description; List<String> get technologies; List<DownloadableArtifactModel> get downloads; List<ArchitectureFeatureModel> get features;
/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectModelCopyWith<ProjectModel> get copyWith => _$ProjectModelCopyWithImpl<ProjectModel>(this as ProjectModel, _$identity);

  /// Serializes this ProjectModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayTier, displayTier) || other.displayTier == displayTier)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.typeIcon, typeIcon) || other.typeIcon == typeIcon)&&(identical(other.coverImageAsset, coverImageAsset) || other.coverImageAsset == coverImageAsset)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.technologies, technologies)&&const DeepCollectionEquality().equals(other.downloads, downloads)&&const DeepCollectionEquality().equals(other.features, features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayTier,publishedAt,title,tagline,typeIcon,coverImageAsset,sourceUrl,description,const DeepCollectionEquality().hash(technologies),const DeepCollectionEquality().hash(downloads),const DeepCollectionEquality().hash(features));

@override
String toString() {
  return 'ProjectModel(id: $id, displayTier: $displayTier, publishedAt: $publishedAt, title: $title, tagline: $tagline, typeIcon: $typeIcon, coverImageAsset: $coverImageAsset, sourceUrl: $sourceUrl, description: $description, technologies: $technologies, downloads: $downloads, features: $features)';
}


}

/// @nodoc
abstract mixin class $ProjectModelCopyWith<$Res>  {
  factory $ProjectModelCopyWith(ProjectModel value, $Res Function(ProjectModel) _then) = _$ProjectModelCopyWithImpl;
@useResult
$Res call({
 String id, DisplayTier displayTier, DateTime publishedAt, String title, String tagline, String typeIcon, String coverImageAsset, String sourceUrl, String description, List<String> technologies, List<DownloadableArtifactModel> downloads, List<ArchitectureFeatureModel> features
});




}
/// @nodoc
class _$ProjectModelCopyWithImpl<$Res>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._self, this._then);

  final ProjectModel _self;
  final $Res Function(ProjectModel) _then;

/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayTier = null,Object? publishedAt = null,Object? title = null,Object? tagline = null,Object? typeIcon = null,Object? coverImageAsset = null,Object? sourceUrl = null,Object? description = null,Object? technologies = null,Object? downloads = null,Object? features = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayTier: null == displayTier ? _self.displayTier : displayTier // ignore: cast_nullable_to_non_nullable
as DisplayTier,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,typeIcon: null == typeIcon ? _self.typeIcon : typeIcon // ignore: cast_nullable_to_non_nullable
as String,coverImageAsset: null == coverImageAsset ? _self.coverImageAsset : coverImageAsset // ignore: cast_nullable_to_non_nullable
as String,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as List<DownloadableArtifactModel>,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<ArchitectureFeatureModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectModel].
extension ProjectModelPatterns on ProjectModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectModel value)  $default,){
final _that = this;
switch (_that) {
case _ProjectModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DisplayTier displayTier,  DateTime publishedAt,  String title,  String tagline,  String typeIcon,  String coverImageAsset,  String sourceUrl,  String description,  List<String> technologies,  List<DownloadableArtifactModel> downloads,  List<ArchitectureFeatureModel> features)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
return $default(_that.id,_that.displayTier,_that.publishedAt,_that.title,_that.tagline,_that.typeIcon,_that.coverImageAsset,_that.sourceUrl,_that.description,_that.technologies,_that.downloads,_that.features);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DisplayTier displayTier,  DateTime publishedAt,  String title,  String tagline,  String typeIcon,  String coverImageAsset,  String sourceUrl,  String description,  List<String> technologies,  List<DownloadableArtifactModel> downloads,  List<ArchitectureFeatureModel> features)  $default,) {final _that = this;
switch (_that) {
case _ProjectModel():
return $default(_that.id,_that.displayTier,_that.publishedAt,_that.title,_that.tagline,_that.typeIcon,_that.coverImageAsset,_that.sourceUrl,_that.description,_that.technologies,_that.downloads,_that.features);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DisplayTier displayTier,  DateTime publishedAt,  String title,  String tagline,  String typeIcon,  String coverImageAsset,  String sourceUrl,  String description,  List<String> technologies,  List<DownloadableArtifactModel> downloads,  List<ArchitectureFeatureModel> features)?  $default,) {final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
return $default(_that.id,_that.displayTier,_that.publishedAt,_that.title,_that.tagline,_that.typeIcon,_that.coverImageAsset,_that.sourceUrl,_that.description,_that.technologies,_that.downloads,_that.features);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectModel extends ProjectModel {
  const _ProjectModel({required this.id, required this.displayTier, required this.publishedAt, required this.title, required this.tagline, required this.typeIcon, required this.coverImageAsset, required this.sourceUrl, required this.description, required final  List<String> technologies, final  List<DownloadableArtifactModel> downloads = const [], final  List<ArchitectureFeatureModel> features = const []}): _technologies = technologies,_downloads = downloads,_features = features,super._();
  factory _ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);

@override final  String id;
@override final  DisplayTier displayTier;
@override final  DateTime publishedAt;
@override final  String title;
@override final  String tagline;
@override final  String typeIcon;
@override final  String coverImageAsset;
@override final  String sourceUrl;
@override final  String description;
 final  List<String> _technologies;
@override List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}

 final  List<DownloadableArtifactModel> _downloads;
@override@JsonKey() List<DownloadableArtifactModel> get downloads {
  if (_downloads is EqualUnmodifiableListView) return _downloads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_downloads);
}

 final  List<ArchitectureFeatureModel> _features;
@override@JsonKey() List<ArchitectureFeatureModel> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}


/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectModelCopyWith<_ProjectModel> get copyWith => __$ProjectModelCopyWithImpl<_ProjectModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayTier, displayTier) || other.displayTier == displayTier)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.typeIcon, typeIcon) || other.typeIcon == typeIcon)&&(identical(other.coverImageAsset, coverImageAsset) || other.coverImageAsset == coverImageAsset)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._technologies, _technologies)&&const DeepCollectionEquality().equals(other._downloads, _downloads)&&const DeepCollectionEquality().equals(other._features, _features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayTier,publishedAt,title,tagline,typeIcon,coverImageAsset,sourceUrl,description,const DeepCollectionEquality().hash(_technologies),const DeepCollectionEquality().hash(_downloads),const DeepCollectionEquality().hash(_features));

@override
String toString() {
  return 'ProjectModel(id: $id, displayTier: $displayTier, publishedAt: $publishedAt, title: $title, tagline: $tagline, typeIcon: $typeIcon, coverImageAsset: $coverImageAsset, sourceUrl: $sourceUrl, description: $description, technologies: $technologies, downloads: $downloads, features: $features)';
}


}

/// @nodoc
abstract mixin class _$ProjectModelCopyWith<$Res> implements $ProjectModelCopyWith<$Res> {
  factory _$ProjectModelCopyWith(_ProjectModel value, $Res Function(_ProjectModel) _then) = __$ProjectModelCopyWithImpl;
@override @useResult
$Res call({
 String id, DisplayTier displayTier, DateTime publishedAt, String title, String tagline, String typeIcon, String coverImageAsset, String sourceUrl, String description, List<String> technologies, List<DownloadableArtifactModel> downloads, List<ArchitectureFeatureModel> features
});




}
/// @nodoc
class __$ProjectModelCopyWithImpl<$Res>
    implements _$ProjectModelCopyWith<$Res> {
  __$ProjectModelCopyWithImpl(this._self, this._then);

  final _ProjectModel _self;
  final $Res Function(_ProjectModel) _then;

/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayTier = null,Object? publishedAt = null,Object? title = null,Object? tagline = null,Object? typeIcon = null,Object? coverImageAsset = null,Object? sourceUrl = null,Object? description = null,Object? technologies = null,Object? downloads = null,Object? features = null,}) {
  return _then(_ProjectModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayTier: null == displayTier ? _self.displayTier : displayTier // ignore: cast_nullable_to_non_nullable
as DisplayTier,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,typeIcon: null == typeIcon ? _self.typeIcon : typeIcon // ignore: cast_nullable_to_non_nullable
as String,coverImageAsset: null == coverImageAsset ? _self.coverImageAsset : coverImageAsset // ignore: cast_nullable_to_non_nullable
as String,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,downloads: null == downloads ? _self._downloads : downloads // ignore: cast_nullable_to_non_nullable
as List<DownloadableArtifactModel>,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<ArchitectureFeatureModel>,
  ));
}


}

// dart format on
