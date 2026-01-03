// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'architecture_feature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArchitectureFeatureModel {

 String get title; String get description; String get icon;
/// Create a copy of ArchitectureFeatureModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchitectureFeatureModelCopyWith<ArchitectureFeatureModel> get copyWith => _$ArchitectureFeatureModelCopyWithImpl<ArchitectureFeatureModel>(this as ArchitectureFeatureModel, _$identity);

  /// Serializes this ArchitectureFeatureModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchitectureFeatureModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,icon);

@override
String toString() {
  return 'ArchitectureFeatureModel(title: $title, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $ArchitectureFeatureModelCopyWith<$Res>  {
  factory $ArchitectureFeatureModelCopyWith(ArchitectureFeatureModel value, $Res Function(ArchitectureFeatureModel) _then) = _$ArchitectureFeatureModelCopyWithImpl;
@useResult
$Res call({
 String title, String description, String icon
});




}
/// @nodoc
class _$ArchitectureFeatureModelCopyWithImpl<$Res>
    implements $ArchitectureFeatureModelCopyWith<$Res> {
  _$ArchitectureFeatureModelCopyWithImpl(this._self, this._then);

  final ArchitectureFeatureModel _self;
  final $Res Function(ArchitectureFeatureModel) _then;

/// Create a copy of ArchitectureFeatureModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? icon = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ArchitectureFeatureModel].
extension ArchitectureFeatureModelPatterns on ArchitectureFeatureModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArchitectureFeatureModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArchitectureFeatureModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArchitectureFeatureModel value)  $default,){
final _that = this;
switch (_that) {
case _ArchitectureFeatureModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArchitectureFeatureModel value)?  $default,){
final _that = this;
switch (_that) {
case _ArchitectureFeatureModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArchitectureFeatureModel() when $default != null:
return $default(_that.title,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String icon)  $default,) {final _that = this;
switch (_that) {
case _ArchitectureFeatureModel():
return $default(_that.title,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _ArchitectureFeatureModel() when $default != null:
return $default(_that.title,_that.description,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArchitectureFeatureModel extends ArchitectureFeatureModel {
  const _ArchitectureFeatureModel({required this.title, required this.description, required this.icon}): super._();
  factory _ArchitectureFeatureModel.fromJson(Map<String, dynamic> json) => _$ArchitectureFeatureModelFromJson(json);

@override final  String title;
@override final  String description;
@override final  String icon;

/// Create a copy of ArchitectureFeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchitectureFeatureModelCopyWith<_ArchitectureFeatureModel> get copyWith => __$ArchitectureFeatureModelCopyWithImpl<_ArchitectureFeatureModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArchitectureFeatureModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArchitectureFeatureModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,icon);

@override
String toString() {
  return 'ArchitectureFeatureModel(title: $title, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$ArchitectureFeatureModelCopyWith<$Res> implements $ArchitectureFeatureModelCopyWith<$Res> {
  factory _$ArchitectureFeatureModelCopyWith(_ArchitectureFeatureModel value, $Res Function(_ArchitectureFeatureModel) _then) = __$ArchitectureFeatureModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String icon
});




}
/// @nodoc
class __$ArchitectureFeatureModelCopyWithImpl<$Res>
    implements _$ArchitectureFeatureModelCopyWith<$Res> {
  __$ArchitectureFeatureModelCopyWithImpl(this._self, this._then);

  final _ArchitectureFeatureModel _self;
  final $Res Function(_ArchitectureFeatureModel) _then;

/// Create a copy of ArchitectureFeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? icon = null,}) {
  return _then(_ArchitectureFeatureModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
