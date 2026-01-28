import 'package:flutter/foundation.dart';

@immutable
class ProjectViewModel {
  const ProjectViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.techStack,
    this.appType,
  });
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> techStack;
  final String? appType;
}
