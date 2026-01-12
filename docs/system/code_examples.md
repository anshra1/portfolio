# Gold Standard Code Examples

This document contains the **authoritative code templates** for this project.
**AI Agents MUST copy these patterns exactly** when generating new features.

---

## 1. Domain Layer (`lib/features/[feature]/domain/`)

**Status:** PURE DART. No Flutter dependencies (except `equatable`).
**Goal:** Define the "Business Truth".

### 1.1 Entity
**Path:** `.../domain/entities/article.dart`
**Rules:** `Equatable`, `final` fields, standard constructor.

```dart
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedAt,
  });

  final String id;
  final String title;
  final String content;
  final DateTime publishedAt;

  @override
  List<Object?> get props => [id, title, content, publishedAt];
}
```

### 1.2 Repository Interface
**Path:** `.../domain/repositories/article_repository.dart`
**Rules:** Return `ResultFuture<T>` or `ResultStream<T>`. No implementation.

```dart
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';

abstract class ArticleRepository {
  ResultFuture<List<Article>> getArticles({int page = 1});
  ResultFuture<Article> getArticleDetail(String id);
}
```

### 1.3 Use Case (Grouped)
**Path:** `.../domain/usecases/article_usecase.dart`
**Rules:** Group all feature use cases in **ONE** file.

```dart
import 'package:portfolio/core/common/usecase.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/repositories/article_repository.dart';

class GetArticles extends FutureUseCaseWithParams<List<Article>, int> {
  const GetArticles(this._repository);
  final ArticleRepository _repository;

  @override
  ResultFuture<List<Article>> call(int params) => 
      _repository.getArticles(page: params);
}

class GetArticleDetail extends FutureUseCaseWithParams<Article, String> {
  const GetArticleDetail(this._repository);
  final ArticleRepository _repository;

  @override
  ResultFuture<Article> call(String params) => 
      _repository.getArticleDetail(params);
}
```

---

## 2. Data Layer (`lib/features/[feature]/data/`)

**Status:** INFRASTRUCTURE. Handles serialization, API calls, and mapping.
**Goal:** Fetch data and convert it to Domain Entities.

### 2.1 Model (Freezed)
**Path:** `.../data/models/article_model.dart`
**Rules:** Use `freezed`, `json_serializable`, and implement `toEntity()`.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required String id,
    required String title,
    required String body, // API might call it 'body', Entity calls it 'content'
    required DateTime createdAt,
  }) = _ArticleModel;

  const ArticleModel._(); // Needed for custom methods

  factory ArticleModel.fromJson(Map<String, dynamic> json) => 
      _$ArticleModelFromJson(json);

  /// Maps DTO to Domain Entity
  Article toEntity() {
    return Article(
      id: id,
      title: title,
      content: body,
      publishedAt: createdAt,
    );
  }
}
```

### 2.2 Data Source (Remote)
**Path:** `.../data/datasources/article_remote_data_source.dart`
**Rules:** Throw `ServerException`. Return `Model`. No `Either`.

```dart
import 'package:portfolio/core/error/exception.dart';
import 'package:portfolio/features/articles/data/models/article_model.dart';
import 'package:dio/dio.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles(int page);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  const ArticleRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<ArticleModel>> getArticles(int page) async {
    try {
      final response = await _dio.get('/articles', queryParameters: {'page': page});
      final data = response.data as List;
      return data.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e, s) {
      throw ServerException(
        methodName: 'getArticles',
        originalError: e.toString(),
        stackTrace: s.toString(),
        userMessage: 'Failed to fetch articles.',
        title: 'Network Error',
      );
    }
  }
}
```

### 2.3 Repository Implementation
**Path:** `.../data/repositories/article_repository_impl.dart`
**Rules:** Catch exceptions, map to `Failure`, return `Right` with Entities.

```dart
import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/error/error_mapper.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/repositories/article_repository.dart';
import 'package:portfolio/features/articles/data/datasources/article_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  const ArticleRepositoryImpl(this._remoteDataSource);
  final ArticleRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Article>> getArticles({int page = 1}) async {
    try {
      final models = await _remoteDataSource.getArticles(page);
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<Article> getArticleDetail(String id) {
    // Implementation skipped for brevity, follows same pattern
    throw UnimplementedError();
  }
}
```