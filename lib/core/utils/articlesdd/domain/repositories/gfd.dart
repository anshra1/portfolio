import 'package:portfolio/core/utils/articlesdd/entity/333.dart';

abstract class ArticleRepository {
  Future<List<Article>> getArticles({
    String? searchQuery,
    String? tag,
    String? sortOrder,
    int page = 1,
  });

  Future<Article?> getArticleById(String id);

  Future<List<Article>> getFeaturedArticles();

  Future<List<String>> getTags();
}
