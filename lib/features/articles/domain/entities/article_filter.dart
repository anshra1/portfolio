import 'package:equatable/equatable.dart';
import 'package:portfolio/core/common/enums.dart';

class ArticleFilter extends Equatable {
  const ArticleFilter({
    this.searchQuery,
    this.tags = const [],
    this.sortOrder,
  });

  final String? searchQuery;

  /// List of tags to filter by
  final List<String> tags;
  final SortOrder? sortOrder;

  @override
  List<Object?> get props => [searchQuery, tags, sortOrder];
}
