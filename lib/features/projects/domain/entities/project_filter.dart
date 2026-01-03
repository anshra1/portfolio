import 'package:equatable/equatable.dart';
import 'package:portfolio/core/common/enums.dart';

class ProjectFilter extends Equatable {
  const ProjectFilter({
    this.searchQuery,
    this.technology,
    this.sortOrder,
  });

  final String? searchQuery;
  final String? technology;
  final SortOrder? sortOrder;

  @override
  List<Object?> get props => [searchQuery, technology, sortOrder];
}
