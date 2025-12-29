import 'package:dartz/dartz.dart';
import 'package:portfolio/core/common/enums.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:portfolio/features/articles/data/models/article_filter_model.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';
import 'package:portfolio/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  const ArticleRepositoryImpl(this._remoteDataSource);

  final ArticlesRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Article>> getArticles({
    required int page,
    required ArticleFilter filter,
    int? limit,
  }) async {
    try {
      // Logic Engine: Fetch all to apply ranked sorting in-memory.
      final allModels = await _remoteDataSource.getArticles(
        page: 1,
        filter: const ArticleFilterModel(),
        limit: 1000,
      );

      var articles = allModels.map((e) => e.toEntity()).toList();

      // 1. Apply Search Filtering
      if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
        final query = filter.searchQuery!.toLowerCase();
        articles = articles.where((a) {
          return a.title.toLowerCase().contains(query) ||
              a.summary.toLowerCase().contains(query);
        }).toList();
      }

      // 2. Apply Tag Filtering
      if (filter.tag != null && filter.tag!.isNotEmpty) {
        articles = articles.where((a) {
          return a.tags.any(
            (t) => t.toLowerCase() == filter.tag!.toLowerCase(),
          );
        }).toList();
      }

      // 3. Apply Ranked Sorting
      // Primary: Display Tier (Hero > Standard)
      // Secondary: Date (Newest > Oldest)
      articles.sort((a, b) {
        final tierResult = a.displayTier.index.compareTo(b.displayTier.index);
        if (tierResult != 0) {
          return tierResult;
        }

        if (filter.sortOrder == SortOrder.oldest) {
          return a.publishedAt.compareTo(b.publishedAt);
        }

        return b.publishedAt.compareTo(a.publishedAt);
      });

      // 4. Apply Pagination
      final effectiveLimit = limit ?? 10;
      final startIndex = (page - 1) * effectiveLimit;

      if (startIndex >= articles.length) {
        return const Right([]);
      }

      final endIndex = (startIndex + effectiveLimit) > articles.length
          ? articles.length
          : (startIndex + effectiveLimit);

      return Right(articles.sublist(startIndex, endIndex));
    } catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<Article> getArticleDetail(String articleId) async {
    try {
      final model = await _remoteDataSource.getArticleDetail(articleId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }
}
