import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:portfolio/features/articles/data/models/article_filter_model.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_display_tier.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';
import 'package:portfolio/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  ArticleRepositoryImpl({required this.remoteDataSource});
  final ArticlesRemoteDataSource remoteDataSource;

  @override
  ResultFuture<List<Article>> getArticles({
    required int page,
    required ArticleFilter filter,
    int? limit,
  }) async {
    try {
      // Step 1: Sanitize Inputs
      final sanitizedPage = page < 1 ? 1 : page;
      final sanitizedLimit = (limit == null || limit <= 0) ? 10 : limit;
      final normalizedQuery = filter.searchQuery?.trim().toLowerCase() ?? '';
      final normalizedTags = filter.tags.map((t) => t.toLowerCase()).toList();

      // Step 2: Fetch Data (Fetch all for in-memory processing)
      // We pass an empty filter to ensure we get the full dataset
      final models = await remoteDataSource.getArticles(
        page: 1,
        filter: const ArticleFilterModel(),
      );

      var articles = models.map((m) => m.toEntity()).toList();

      // Step 3: Deduplication
      final seenIds = <String>{};
      final uniqueArticles = <Article>[];
      for (final article in articles) {
        if (seenIds.add(article.id)) {
          uniqueArticles.add(article);
        } else {
          // Logged silently as per MD (implicitly via no-op here,
          // but could use Talker if injected)
        }
      }
      articles = uniqueArticles;

      // Step 4: Filter: Visibility
      articles = articles
          .where((a) => a.displayTier != ArticleDisplayTier.hidden)
          .toList();

      // Step 5: Filter: Tags
      if (normalizedTags.isNotEmpty) {
        articles = articles.where((article) {
          final articleTags = article.tags.map((t) => t.toLowerCase()).toSet();
          return normalizedTags.any(articleTags.contains);
        }).toList();
      }

      // Step 6: Filter: Search Query
      if (normalizedQuery.isNotEmpty) {
        articles = articles.where((article) {
          return article.title.toLowerCase().contains(normalizedQuery);
        }).toList();
      }

      // Step 7: Rank: Tier-Preserving Strategy
      articles.sort((a, b) {
        // Primary Sort: displayTier (Hero [0] > Standard [1])
        // Hero = 0, Standard = 1, Hidden = 2 (but Hidden are filtered out)
        final tierComparison = a.displayTier.index.compareTo(b.displayTier.index);
        if (tierComparison != 0) return tierComparison;

        // Secondary Sort: publishedAt (Newest first)
        final dateComparison = b.publishedAt.compareTo(a.publishedAt);
        if (dateComparison != 0) return dateComparison;

        // Tie-Breaker: id
        return a.id.compareTo(b.id);
      });

      // Step 8: Paginate
      final startIndex = (sanitizedPage - 1) * sanitizedLimit;
      if (startIndex >= articles.length) {
        return const Right([]);
      }

      final endIndex = min(startIndex + sanitizedLimit, articles.length);
      final paginatedList = articles.sublist(startIndex, endIndex);

      return Right(paginatedList);
    } catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<Article> getArticleDetail(String articleId) async {
    try {
      // Step 1: Validate Input
      if (articleId.trim().isEmpty) {
        return const Left(
          ValidationFailure(
            message: 'Article ID cannot be empty',
            title: 'Invalid Input',
          ),
        );
      }

      // Step 2: Fetch Data
      final model = await remoteDataSource.getArticleDetail(articleId);

      // Step 4: Convert & Return
      return Right(model.toEntity());
    } catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }
}
