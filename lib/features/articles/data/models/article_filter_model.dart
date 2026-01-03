import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/core/common/enums.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';

part 'article_filter_model.freezed.dart';
part 'article_filter_model.g.dart';

@freezed
abstract class ArticleFilterModel with _$ArticleFilterModel {
  const factory ArticleFilterModel({
    String? searchQuery,
    @Default([]) List<String> tags,
    SortOrder? sortOrder,
  }) = _ArticleFilterModel;

  const ArticleFilterModel._();

  factory ArticleFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleFilterModelFromJson(json);

  factory ArticleFilterModel.fromEntity(ArticleFilter entity) {
    return ArticleFilterModel(
      searchQuery: entity.searchQuery,
      tags: entity.tags,
      sortOrder: entity.sortOrder,
    );
  }

  ArticleFilter toEntity() {
    return ArticleFilter(
      searchQuery: searchQuery,
      tags: tags,
      sortOrder: sortOrder,
    );
  }
}
