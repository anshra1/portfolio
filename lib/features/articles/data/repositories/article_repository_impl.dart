import 'package:dartz/dartz.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';
import 'package:portfolio/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  ArticleRepositoryImpl({required this.remoteDataSource});
  final ArticlesRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<Article>>> getArticles({
    required int page,
    required ArticleFilter filter,
    int? limit,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Article>> getArticleDetail(String articleId) {
    throw UnimplementedError();
  }
}
