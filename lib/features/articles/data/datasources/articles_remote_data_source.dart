import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/core/services/talker_service.dart';
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

class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource {
  ArticlesRemoteDataSourceImpl({
    required AssetBundle assetBundle,
    required TalkerService talkerService,
  }) : _assetBundle = assetBundle,
       _talkerService = talkerService;

  final AssetBundle _assetBundle;
  final TalkerService _talkerService;

  List<ArticleModel>? _cachedArticles;
  Future<void>? _initFuture;

  Future<void> _ensureInitialized() async {
    if (_cachedArticles != null) return;

    if (_initFuture != null) {
      await _initFuture;
      if (_cachedArticles != null) return;
    }

    _initFuture = _loadArticles();
    try {
      await _initFuture;
    } catch (e) {
      _initFuture = null;
      rethrow;
    }
  }

  Future<void> _loadArticles() async {
    try {
      final jsonString = await _assetBundle.loadString(
        'database/articles/articles.json',
      );
      final (articles, errors) = await compute(_parseArticles, jsonString);

      if (errors.isNotEmpty) {
        for (final error in errors) {
          _talkerService.warning('Skipping corrupt article record: $error');
        }
      }

      _cachedArticles = articles;
    } catch (e, stackTrace) {
      if (e is DataParsingException) rethrow;
      throw DataParsingException(
        methodName: 'getArticles',
        originalError: e.toString(),
        stackTrace: stackTrace.toString(),
        title: 'Failed to load articles',
      );
    }
  }

  @override
  Future<List<ArticleModel>> getArticles({
    required int page,
    required ArticleFilterModel filter,
    int? limit,
  }) async {
    await _ensureInitialized();
    return _cachedArticles!;
  }

  @override
  Future<ArticleModel> getArticleDetail(String articleId) async {
    await _ensureInitialized();

    final article = _cachedArticles!.firstWhere(
      (a) => a.id == articleId,
      orElse: () => throw NotFoundException(
        methodName: 'getArticleDetail',
        originalError: 'Article with ID $articleId not found in registry',
        title: 'Article Not Found',
      ),
    );

    if (article.contentPath.isEmpty) {
      throw DataParsingException(
        methodName: 'getArticleDetail',
        originalError: 'Article $articleId missing contentPath',
        title: 'Corrupt Article Record',
      );
    }

    final contentPath = article.contentPath;
    if (!contentPath.startsWith('database/articles/content/') ||
        contentPath.contains('..')) {
      _talkerService.warning('Security: Path traversal attempt detected: $contentPath');
      throw DataParsingException(
        methodName: 'getArticleDetail',
        originalError: 'Invalid content path: $contentPath',
        title: 'Security Violation',
      );
    }

    try {
      final byteData = await _assetBundle.load(contentPath);

      if (byteData.lengthInBytes > 5 * 1024 * 1024) {
        throw DataParsingException(
          methodName: 'getArticleDetail',
          originalError: 'File size exceeds 5MB limit: ${byteData.lengthInBytes} bytes',
          title: 'Oversized Asset',
        );
      }

      final bytes = byteData.buffer.asUint8List();
      final content = utf8.decode(bytes, allowMalformed: false);

      return article.copyWith(content: content);
    } catch (e, stackTrace) {
      if (e is DataParsingException) rethrow;
      if (e is FormatException) {
        throw DataParsingException(
          methodName: 'getArticleDetail',
          originalError: 'Encoding Error: ${e.message}',
          title: 'Encoding Error',
          stackTrace: stackTrace.toString(),
        );
      }
      throw DataParsingException(
        methodName: 'getArticleDetail',
        originalError: 'Failed to load content file: $e',
        title: 'Content Load Failed',
        stackTrace: stackTrace.toString(),
      );
    }
  }
}

(List<ArticleModel>, List<String>) _parseArticles(String jsonString) {
  final jsonList = jsonDecode(jsonString) as List<dynamic>;
  final validArticles = <ArticleModel>[];
  final errors = <String>[];

  for (final item in jsonList) {
    try {
      validArticles.add(ArticleModel.fromJson(item as Map<String, dynamic>));
    } catch (e) {
      errors.add(e.toString());
    }
  }
  return (validArticles, errors);
}
