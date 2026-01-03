// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloadable_artifact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DownloadableArtifactModel _$DownloadableArtifactModelFromJson(
  Map<String, dynamic> json,
) => _DownloadableArtifactModel(
  platformName: json['platformName'] as String,
  version: json['version'] as String,
  metaInfo: json['metaInfo'] as String,
  type: $enumDecode(_$ArtifactTypeEnumMap, json['type']),
  actionUrl: json['actionUrl'] as String,
);

Map<String, dynamic> _$DownloadableArtifactModelToJson(
  _DownloadableArtifactModel instance,
) => <String, dynamic>{
  'platformName': instance.platformName,
  'version': instance.version,
  'metaInfo': instance.metaInfo,
  'type': _$ArtifactTypeEnumMap[instance.type]!,
  'actionUrl': instance.actionUrl,
};

const _$ArtifactTypeEnumMap = {
  ArtifactType.binary: 'binary',
  ArtifactType.store: 'store',
};
