// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleFilterModel _$ArticleFilterModelFromJson(Map<String, dynamic> json) =>
    _ArticleFilterModel(
      searchQuery: json['searchQuery'] as String?,
      tag: json['tag'] as String?,
      sortOrder: $enumDecodeNullable(_$SortOrderEnumMap, json['sortOrder']),
    );

Map<String, dynamic> _$ArticleFilterModelToJson(_ArticleFilterModel instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'tag': instance.tag,
      'sortOrder': _$SortOrderEnumMap[instance.sortOrder],
    };

const _$SortOrderEnumMap = {
  SortOrder.newest: 'newest',
  SortOrder.oldest: 'oldest',
  SortOrder.popular: 'popular',
};
