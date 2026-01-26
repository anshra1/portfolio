import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/models/project_display_model.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';

/// Maps a domain [Project] entity to a UI [ProjectDisplayModel].
ProjectDisplayModel mapProjectToDisplayModel(Project project) {
  return ProjectDisplayModel(
    title: project.title,
    description: project.tagline,
    imageUrl: project.coverImageAsset,
    tags: project.technologies,
    typeIcon: _mapTypeIcon(project.typeIcon),
    onViewCode: project.sourceUrl.isNotEmpty ? project.sourceUrl : null,
  );
}

IconData _mapTypeIcon(String iconName) {
  switch (iconName) {
    case 'smartphone':
      return Icons.smartphone;
    case 'groups':
      return Icons.groups;
    case 'rocket_launch':
      return Icons.rocket_launch;
    case 'web':
      return Icons.web;
    case 'code':
      return Icons.code;
    default:
      return Icons.apps;
  }
}
