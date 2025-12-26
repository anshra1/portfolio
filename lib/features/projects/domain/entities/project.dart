import 'package:equatable/equatable.dart';
import 'package:portfolio/features/projects/domain/entities/architecture_feature.dart';
import 'package:portfolio/features/projects/domain/entities/downloadable_artifact.dart';

class Project extends Equatable {
  const Project({
    required this.id,
    required this.isFeatured,
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
  final bool isFeatured;
  final String title;
  final String tagline;
  final String typeIcon;
  final String coverImageAsset;
  final String sourceUrl;
  final String description;
  final List<String> technologies;
  final List<DownloadableArtifact> downloads;
  final List<ArchitectureFeature> features;

  @override
  List<Object?> get props => [
    id,
    isFeatured,
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
