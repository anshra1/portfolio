import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_detail.dart';
import 'package:portfolio/features/articles/domain/entities/filter_state.dart';

abstract interface class ArticleRepository {
  /// Fetches a list of articles based on pagination and filters.
  ResultFuture<List<Article>> getArticles({
    required int page,
    required FilterState filter,
    int? limit,
  });

  /// Fetches the full details of a specific article.
  ResultFuture<ArticleDetail> getArticleDetail(String articleId);

  /// Fetches the features article
  
}
