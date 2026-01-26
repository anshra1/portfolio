import 'package:intl/intl.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/homepage/presentation/models/insight_view_model.dart';

/// Maps a domain [Article] entity to a UI [InsightViewModel].
InsightViewModel mapArticleToInsightViewModel(Article article) {
  return InsightViewModel(
    id: article.id,
    imageUrl: article.coverImageAsset,
    title: article.title,
    date: DateFormat('MMM dd, yyyy').format(article.publishedAt),
    readTime: article.readTime,
    tags: article.tags,
    description: article.summary,
  );
}
