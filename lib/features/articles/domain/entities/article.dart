import 'package:equatable/equatable.dart';
import 'package:portfolio/features/articles/domain/entities/article_display_tier.dart';

class Article extends Equatable {
  const Article({
    required this.id,
    required this.displayTier,
    required this.publishedAt,
    required this.title,
    required this.readTime,
    required this.summary,
    required this.contentBody,
    required this.tags,
    required this.coverImageAsset,
  });

  final String id;
  final ArticleDisplayTier displayTier;
  final DateTime publishedAt;
  final String title;
  final String readTime;
  final String summary;
  final String contentBody;
  final List<String> tags;
  final String coverImageAsset;

  /// Computed property to determine if an article is considered "featured".
  bool get isFeatured => displayTier == ArticleDisplayTier.hero;

  @override
  List<Object?> get props => [
        id,
        displayTier,
        publishedAt,
        title,
        readTime,
        summary,
        contentBody,
        tags,
        coverImageAsset,
      ];
}