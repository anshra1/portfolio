import 'package:portfolio/features/articles/data/models/article_filter_model.dart';
import 'package:portfolio/features/articles/data/models/article_model.dart';

abstract interface class ArticlesRemoteDataSource {
  Future<List<ArticleModel>> getArticles({
    required int page,
    required ArticleFilterModel filter,
    int? limit,
  });

  Future<ArticleModel> getArticleDetail(String articleId);
}
