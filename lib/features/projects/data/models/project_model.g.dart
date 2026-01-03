// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectModel _$ProjectModelFromJson(
  Map<String, dynamic> json,
) => _ProjectModel(
  id: json['id'] as String,
  displayTier: $enumDecode(_$DisplayTierEnumMap, json['displayTier']),
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  title: json['title'] as String,
  tagline: json['tagline'] as String,
  typeIcon: json['typeIcon'] as String,
  coverImageAsset: json['coverImageAsset'] as String,
  sourceUrl: json['sourceUrl'] as String,
  description: json['description'] as String,
  technologies: (json['technologies'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  downloads:
      (json['downloads'] as List<dynamic>?)
          ?.map(
            (e) =>
                DownloadableArtifactModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  features:
      (json['features'] as List<dynamic>?)
          ?.map(
            (e) => ArchitectureFeatureModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProjectModelToJson(_ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayTier': _$DisplayTierEnumMap[instance.displayTier],
      'publishedAt': instance.publishedAt.toIso8601String(),
      'title': instance.title,
      'tagline': instance.tagline,
      'typeIcon': instance.typeIcon,
      'coverImageAsset': instance.coverImageAsset,
      'sourceUrl': instance.sourceUrl,
      'description': instance.description,
      'technologies': instance.technologies,
      'downloads': instance.downloads,
      'features': instance.features,
    };

const Map<DisplayTier, String> _$DisplayTierEnumMap = {
  DisplayTier.hero: 'hero',
  DisplayTier.showcase: 'showcase',
  DisplayTier.standard: 'standard',
  DisplayTier.hidden: 'hidden',
};
