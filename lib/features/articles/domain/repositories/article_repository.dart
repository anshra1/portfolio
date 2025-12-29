import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';

abstract interface class ArticleRepository {
  ResultFuture<List<Article>> getArticles({
    required int page,
    required ArticleFilter filter,
    int? limit,
  });

  ResultFuture<Article> getArticleDetail(String articleId);
}