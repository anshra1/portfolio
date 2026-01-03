// PATH: lib/features/projects/data/models/downloadable_artifact_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/projects/domain/entities/downloadable_artifact.dart';

part 'downloadable_artifact_model.freezed.dart';
part 'downloadable_artifact_model.g.dart';

@freezed
abstract class DownloadableArtifactModel with _$DownloadableArtifactModel {
  const factory DownloadableArtifactModel({
    required String platformName,
    required String version,
    required String metaInfo,
    required ArtifactType type,
    required String actionUrl,
  }) = _DownloadableArtifactModel;

  const DownloadableArtifactModel._();

  factory DownloadableArtifactModel.fromJson(Map<String, dynamic> json) =>
      _$DownloadableArtifactModelFromJson(json);

  factory DownloadableArtifactModel.fromEntity(DownloadableArtifact entity) {
    return DownloadableArtifactModel(
      platformName: entity.platformName,
      version: entity.version,
      metaInfo: entity.metaInfo,
      type: entity.type,
      actionUrl: entity.actionUrl,
    );
  }

  DownloadableArtifact toEntity() {
    return DownloadableArtifact(
      platformName: platformName,
      version: version,
      metaInfo: metaInfo,
      type: type,
      actionUrl: actionUrl,
    );
  }
}
