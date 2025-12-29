// PATH: lib/features/projects/data/models/project_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/projects/data/models/architecture_feature_model.dart';
import 'package:portfolio/features/projects/data/models/downloadable_artifact_model.dart';
import 'package:portfolio/features/projects/domain/entities/display_tier.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';

part 'project_model.freezed.dart';
part 'project_model.g.dart';

@freezed
abstract class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required DisplayTier displayTier,
    required DateTime publishedAt,
    required String title,
    required String tagline,
    required String typeIcon,
    required String coverImageAsset,
    required String sourceUrl,
    required String description,
    required List<String> technologies,
    @Default([]) List<DownloadableArtifactModel> downloads,
    @Default([]) List<ArchitectureFeatureModel> features,
  }) = _ProjectModel;

  const ProjectModel._();

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  factory ProjectModel.fromEntity(Project entity) {
    return ProjectModel(
      id: entity.id,
      displayTier: entity.displayTier,
      publishedAt: entity.publishedAt,
      title: entity.title,
      tagline: entity.tagline,
      typeIcon: entity.typeIcon,
      coverImageAsset: entity.coverImageAsset,
      sourceUrl: entity.sourceUrl,
      description: entity.description,
      technologies: entity.technologies,
      downloads: entity.downloads
          .map(DownloadableArtifactModel.fromEntity)
          .toList(),
      features: entity.features
          .map(ArchitectureFeatureModel.fromEntity)
          .toList(),
    );
  }

  Project toEntity() {
    return Project(
      id: id,
      displayTier: displayTier,
      publishedAt: publishedAt,
      title: title,
      tagline: tagline,
      typeIcon: typeIcon,
      coverImageAsset: coverImageAsset,
      sourceUrl: sourceUrl,
      description: description,
      technologies: technologies,
      downloads: downloads.map((e) => e.toEntity()).toList(),
      features: features.map((e) => e.toEntity()).toList(),
    );
  }
}
