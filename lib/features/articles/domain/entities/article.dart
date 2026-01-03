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
    required this.contentPath,
    required this.tags,
    required this.coverImageAsset,
    this.content,
  });

  final String id;
  final ArticleDisplayTier displayTier;
  final DateTime publishedAt;
  final String title;
  final String readTime;
  final String summary;
  final String contentPath;
  final List<String> tags;
  final String coverImageAsset;

  /// The full markdown content of the article.
  /// Loaded lazily via the [contentPath].
  final String? content;

  

  @override
  List<Object?> get props => [
        id,
        displayTier,
        publishedAt,
        title,
        readTime,
        summary,
        contentPath,
        tags,
        coverImageAsset,
        content,
      ];

  /// Creates a copy of this Article with the given [content].
  Article copyWith({String? content}) {
    return Article(
      id: id,
      displayTier: displayTier,
      publishedAt: publishedAt,
      title: title,
      readTime: readTime,
      summary: summary,
      contentPath: contentPath,
      tags: tags,
      coverImageAsset: coverImageAsset,
      content: content ?? this.content,
    );
  }
}