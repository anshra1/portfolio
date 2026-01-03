import 'package:equatable/equatable.dart';
import 'package:portfolio/core/common/enums.dart';

class ArticleFilter extends Equatable {
  const ArticleFilter({
    this.searchQuery,
    this.tag,
    this.sortOrder,
  });

  final String? searchQuery;
  final String? tag;
  final SortOrder? sortOrder;

  @override
  List<Object?> get props => [searchQuery, tag, sortOrder];
}
