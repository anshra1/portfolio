import 'package:flutter/material.dart';

@immutable
class ProjectDisplayModel {
  const ProjectDisplayModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.typeIcon,
    this.onViewCode,
  });
  final String title;
  final String description;
  final String imageUrl;
  final List<String> tags;
  final IconData typeIcon;
  final String? onViewCode;
}
