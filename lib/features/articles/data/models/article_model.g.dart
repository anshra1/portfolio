// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) =>
    _ArticleModel(
      id: json['id'] as String,
      displayTier: $enumDecode(
        _$ArticleDisplayTierEnumMap,
        json['displayTier'],
      ),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      title: json['title'] as String,
      readTime: json['readTime'] as String,
      summary: json['summary'] as String,
      contentPath: json['contentPath'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      coverImageAsset: json['coverImageAsset'] as String,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ArticleModelToJson(_ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayTier': _$ArticleDisplayTierEnumMap[instance.displayTier]!,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'title': instance.title,
      'readTime': instance.readTime,
      'summary': instance.summary,
      'contentPath': instance.contentPath,
      'tags': instance.tags,
      'coverImageAsset': instance.coverImageAsset,
      'content': instance.content,
    };

const _$ArticleDisplayTierEnumMap = {
  ArticleDisplayTier.hero: 'hero',
  ArticleDisplayTier.standard: 'standard',
  ArticleDisplayTier.hidden: 'hidden',
};
