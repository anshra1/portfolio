import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_display_tier.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
abstract class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required String id,
    required ArticleDisplayTier displayTier,
    required DateTime publishedAt,
    required String title,
    required String readTime,
    required String summary,
    required String contentBody,
    required List<String> tags,
    required String coverImageAsset,
  }) = _ArticleModel;

  const ArticleModel._();

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  factory ArticleModel.fromEntity(Article entity) {
    return ArticleModel(
      id: entity.id,
      displayTier: entity.displayTier,
      publishedAt: entity.publishedAt,
      title: entity.title,
      readTime: entity.readTime,
      summary: entity.summary,
      contentBody: entity.contentBody,
      tags: entity.tags,
      coverImageAsset: entity.coverImageAsset,
    );
  }

  Article toEntity() {
    return Article(
      id: id,
      displayTier: displayTier,
      publishedAt: publishedAt,
      title: title,
      readTime: readTime,
      summary: summary,
      contentBody: contentBody,
      tags: tags,
      coverImageAsset: coverImageAsset,
    );
  }
}
