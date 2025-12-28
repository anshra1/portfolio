// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectFilterModel _$ProjectFilterModelFromJson(Map<String, dynamic> json) =>
    _ProjectFilterModel(
      searchQuery: json['searchQuery'] as String?,
      technology: json['technology'] as String?,
      sortOrder: $enumDecodeNullable(_$SortOrderEnumMap, json['sortOrder']),
      isFeatured: json['isFeatured'] as bool?,
    );

Map<String, dynamic> _$ProjectFilterModelToJson(_ProjectFilterModel instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'technology': instance.technology,
      'sortOrder': _$SortOrderEnumMap[instance.sortOrder],
      'isFeatured': instance.isFeatured,
    };

const _$SortOrderEnumMap = {
  SortOrder.newest: 'newest',
  SortOrder.oldest: 'oldest',
  SortOrder.popular: 'popular',
};
