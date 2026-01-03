import 'package:equatable/equatable.dart';

enum ArtifactType { binary, store }

class DownloadableArtifact extends Equatable {
  const DownloadableArtifact({
    required this.platformName,
    required this.version,
    required this.metaInfo,
    required this.type,
    required this.actionUrl,
  });
  
  final String platformName;
  final String version;
  final String metaInfo;
  final ArtifactType type;
  final String actionUrl;

  @override
  List<Object?> get props => [
    platformName,
    version,
    metaInfo,
    type,
    actionUrl,
  ];
}
