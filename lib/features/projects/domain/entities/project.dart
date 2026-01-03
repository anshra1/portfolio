import 'package:equatable/equatable.dart';
import 'package:portfolio/features/projects/domain/entities/architecture_feature.dart';
import 'package:portfolio/features/projects/domain/entities/display_tier.dart';
import 'package:portfolio/features/projects/domain/entities/downloadable_artifact.dart';

class Project extends Equatable {
  const Project({
    required this.id,
    required this.displayTier,
    required this.publishedAt,
    required this.title,
    required this.tagline,
    required this.typeIcon,
    required this.coverImageAsset,
    required this.sourceUrl,
    required this.description,
    required this.technologies,
    this.downloads = const [],
    this.features = const [],
  });

  final String id;
  final DisplayTier displayTier;
  final DateTime publishedAt;
  final String title;
  final String tagline;
  final String typeIcon;
  final String coverImageAsset;
  final String sourceUrl;
  final String description;
  final List<String> technologies;
  final List<DownloadableArtifact> downloads;
  final List<ArchitectureFeature> features;

  /// Computed property to determine if a project is considered "featured"
  /// based on its display tier.
  bool get isFeatured =>
      displayTier == DisplayTier.hero || displayTier == DisplayTier.showcase;

  @override
  List<Object?> get props => [
        id,
        displayTier,
        publishedAt,
        title,
        tagline,
        typeIcon,
        coverImageAsset,
        sourceUrl,
        description,
        technologies,
        downloads,
        features,
      ];
}
