import 'package:equatable/equatable.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/common/usecase.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';
import 'package:portfolio/features/articles/domain/repositories/article_repository.dart';

class GetArticlesParams extends Equatable {
  const GetArticlesParams({
    required this.page,
    required this.filter,
    this.limit,
  });

  final int page;
  final ArticleFilter filter;
  final int? limit;

  @override
  List<Object?> get props => [page, filter, limit];
}

class GetArticles extends FutureUseCaseWithParams<List<Article>, GetArticlesParams> {
  const GetArticles(this._repository);

  final ArticleRepository _repository;

  @override
  ResultFuture<List<Article>> call(GetArticlesParams params) async {
    return _repository.getArticles(
      page: params.page,
      filter: params.filter,
      limit: params.limit,
    );
  }
}

class GetArticleDetail extends FutureUseCaseWithParams<Article, String> {
  const GetArticleDetail(this._repository);

  final ArticleRepository _repository;

  @override
  ResultFuture<Article> call(String params) async {
    return _repository.getArticleDetail(params);
  }
}
