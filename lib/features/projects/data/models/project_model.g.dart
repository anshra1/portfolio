// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectModel _$ProjectModelFromJson(
  Map<String, dynamic> json,
) => _ProjectModel(
  id: json['id'] as String,
  isFeatured: json['isFeatured'] as bool,
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
      'isFeatured': instance.isFeatured,
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
