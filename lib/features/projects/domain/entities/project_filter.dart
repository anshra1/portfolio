import 'package:equatable/equatable.dart';
import 'package:portfolio/core/common/enums.dart';

class ProjectFilter extends Equatable {
  const ProjectFilter({
    this.searchQuery,
    this.technology,
    this.sortOrder,
    this.isFeatured,
  });

  final String? searchQuery;
  final String? technology;
  final SortOrder? sortOrder;
  final bool? isFeatured;

  @override
  List<Object?> get props => [searchQuery, technology, sortOrder, isFeatured];
}
