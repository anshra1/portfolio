// PATH: lib/features/projects/data/models/project_filter_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/core/common/enums.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';

part 'project_filter_model.freezed.dart';
part 'project_filter_model.g.dart';

@freezed
abstract class ProjectFilterModel with _$ProjectFilterModel {
  const factory ProjectFilterModel({
    String? searchQuery,
    String? technology,
    SortOrder? sortOrder,
  }) = _ProjectFilterModel;

  const ProjectFilterModel._();

  factory ProjectFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectFilterModelFromJson(json);

  factory ProjectFilterModel.fromEntity(ProjectFilter entity) {
    return ProjectFilterModel(
      searchQuery: entity.searchQuery,
      technology: entity.technology,
      sortOrder: entity.sortOrder,
    );
  }

  ProjectFilter toEntity() {
    return ProjectFilter(
      searchQuery: searchQuery,
      technology: technology,
      sortOrder: sortOrder,
    );
  }
}
