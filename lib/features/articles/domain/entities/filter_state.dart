import 'package:equatable/equatable.dart';
import 'package:portfolio/core/common/enums.dart';

class FilterState extends Equatable {
  const FilterState({
    this.searchQuery,
    this.tag,
    this.sortOrder,
    this.isFeatured,
  });

  final String? searchQuery;
  final String? tag;
  final SortOrder? sortOrder;
  final bool? isFeatured;

  @override
  List<Object?> get props => [searchQuery, tag, sortOrder, isFeatured];
}
