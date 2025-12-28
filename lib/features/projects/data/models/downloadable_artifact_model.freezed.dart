// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'downloadable_artifact_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DownloadableArtifactModel {

 String get platformName; String get version; String get metaInfo; ArtifactType get type; String get actionUrl;
/// Create a copy of DownloadableArtifactModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DownloadableArtifactModelCopyWith<DownloadableArtifactModel> get copyWith => _$DownloadableArtifactModelCopyWithImpl<DownloadableArtifactModel>(this as DownloadableArtifactModel, _$identity);

  /// Serializes this DownloadableArtifactModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DownloadableArtifactModel&&(identical(other.platformName, platformName) || other.platformName == platformName)&&(identical(other.version, version) || other.version == version)&&(identical(other.metaInfo, metaInfo) || other.metaInfo == metaInfo)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platformName,version,metaInfo,type,actionUrl);

@override
String toString() {
  return 'DownloadableArtifactModel(platformName: $platformName, version: $version, metaInfo: $metaInfo, type: $type, actionUrl: $actionUrl)';
}


}

/// @nodoc
abstract mixin class $DownloadableArtifactModelCopyWith<$Res>  {
  factory $DownloadableArtifactModelCopyWith(DownloadableArtifactModel value, $Res Function(DownloadableArtifactModel) _then) = _$DownloadableArtifactModelCopyWithImpl;
@useResult
$Res call({
 String platformName, String version, String metaInfo, ArtifactType type, String actionUrl
});




}
/// @nodoc
class _$DownloadableArtifactModelCopyWithImpl<$Res>
    implements $DownloadableArtifactModelCopyWith<$Res> {
  _$DownloadableArtifactModelCopyWithImpl(this._self, this._then);

  final DownloadableArtifactModel _self;
  final $Res Function(DownloadableArtifactModel) _then;

/// Create a copy of DownloadableArtifactModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platformName = null,Object? version = null,Object? metaInfo = null,Object? type = null,Object? actionUrl = null,}) {
  return _then(_self.copyWith(
platformName: null == platformName ? _self.platformName : platformName // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,metaInfo: null == metaInfo ? _self.metaInfo : metaInfo // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArtifactType,actionUrl: null == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DownloadableArtifactModel].
extension DownloadableArtifactModelPatterns on DownloadableArtifactModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DownloadableArtifactModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DownloadableArtifactModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DownloadableArtifactModel value)  $default,){
final _that = this;
switch (_that) {
case _DownloadableArtifactModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DownloadableArtifactModel value)?  $default,){
final _that = this;
switch (_that) {
case _DownloadableArtifactModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String platformName,  String version,  String metaInfo,  ArtifactType type,  String actionUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DownloadableArtifactModel() when $default != null:
return $default(_that.platformName,_that.version,_that.metaInfo,_that.type,_that.actionUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String platformName,  String version,  String metaInfo,  ArtifactType type,  String actionUrl)  $default,) {final _that = this;
switch (_that) {
case _DownloadableArtifactModel():
return $default(_that.platformName,_that.version,_that.metaInfo,_that.type,_that.actionUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String platformName,  String version,  String metaInfo,  ArtifactType type,  String actionUrl)?  $default,) {final _that = this;
switch (_that) {
case _DownloadableArtifactModel() when $default != null:
return $default(_that.platformName,_that.version,_that.metaInfo,_that.type,_that.actionUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DownloadableArtifactModel extends DownloadableArtifactModel {
  const _DownloadableArtifactModel({required this.platformName, required this.version, required this.metaInfo, required this.type, required this.actionUrl}): super._();
  factory _DownloadableArtifactModel.fromJson(Map<String, dynamic> json) => _$DownloadableArtifactModelFromJson(json);

@override final  String platformName;
@override final  String version;
@override final  String metaInfo;
@override final  ArtifactType type;
@override final  String actionUrl;

/// Create a copy of DownloadableArtifactModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DownloadableArtifactModelCopyWith<_DownloadableArtifactModel> get copyWith => __$DownloadableArtifactModelCopyWithImpl<_DownloadableArtifactModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DownloadableArtifactModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DownloadableArtifactModel&&(identical(other.platformName, platformName) || other.platformName == platformName)&&(identical(other.version, version) || other.version == version)&&(identical(other.metaInfo, metaInfo) || other.metaInfo == metaInfo)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platformName,version,metaInfo,type,actionUrl);

@override
String toString() {
  return 'DownloadableArtifactModel(platformName: $platformName, version: $version, metaInfo: $metaInfo, type: $type, actionUrl: $actionUrl)';
}


}

/// @nodoc
abstract mixin class _$DownloadableArtifactModelCopyWith<$Res> implements $DownloadableArtifactModelCopyWith<$Res> {
  factory _$DownloadableArtifactModelCopyWith(_DownloadableArtifactModel value, $Res Function(_DownloadableArtifactModel) _then) = __$DownloadableArtifactModelCopyWithImpl;
@override @useResult
$Res call({
 String platformName, String version, String metaInfo, ArtifactType type, String actionUrl
});




}
/// @nodoc
class __$DownloadableArtifactModelCopyWithImpl<$Res>
    implements _$DownloadableArtifactModelCopyWith<$Res> {
  __$DownloadableArtifactModelCopyWithImpl(this._self, this._then);

  final _DownloadableArtifactModel _self;
  final $Res Function(_DownloadableArtifactModel) _then;

/// Create a copy of DownloadableArtifactModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platformName = null,Object? version = null,Object? metaInfo = null,Object? type = null,Object? actionUrl = null,}) {
  return _then(_DownloadableArtifactModel(
platformName: null == platformName ? _self.platformName : platformName // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,metaInfo: null == metaInfo ? _self.metaInfo : metaInfo // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArtifactType,actionUrl: null == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
