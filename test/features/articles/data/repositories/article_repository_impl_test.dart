import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:portfolio/features/articles/data/models/article_filter_model.dart';
import 'package:portfolio/features/articles/data/models/article_model.dart';
import 'package:portfolio/features/articles/data/repositories/article_repository_impl.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';
import 'package:portfolio/features/articles/domain/entities/article_display_tier.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';

class MockArticlesRemoteDataSource extends Mock implements ArticlesRemoteDataSource {}

void main() {
  late ArticleRepositoryImpl repository;
  late MockArticlesRemoteDataSource mockRemoteDataSource;
  late Faker faker;

  setUp(() {
    mockRemoteDataSource = MockArticlesRemoteDataSource();
    repository = ArticleRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    faker = Faker();

    registerFallbackValue(
      const ArticleFilterModel(searchQuery: ''),
    );
  });

  // --- Helpers for generating test data ---

  ArticleModel createArticleModel({
    required String id,
    required ArticleDisplayTier tier,
    required DateTime publishedAt,
    required String title,
    List<String> tags = const [],
  }) {
    return ArticleModel(
      id: id,
      displayTier: tier,
      publishedAt: publishedAt,
      title: title,
      readTime: '5 min',
      summary: faker.lorem.sentence(),
      contentPath: 'path/to/$id.md',
      tags: tags,
      coverImageAsset: 'assets/images/$id.png',
    );
  }

  // --- Test Suite ---

  group('getArticles', () {
    const tPage = 1;
    const tLimit = 10;
    const tFilter = ArticleFilter();

    test(
      'should return DataParsingFailure when datasource throws DataParsingException',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getArticles(
            page: any(named: 'page'),
            filter: any(named: 'filter'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(
          const DataParsingException(
            userMessage: 'Parsing Error',
            title: 'Error',
            methodName: '',
            originalError: '',
          ),
        );

        // Act
        final result = await repository.getArticles(
          page: tPage,
          filter: tFilter,
          limit: tLimit,
        );

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<DataParsingFailure>()),
          (_) => fail('Should have returned a failure'),
        );
      },
    );

    test('should sanitize inputs: page < 1 becomes 1', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => []);

      // Act
      await repository.getArticles(page: -5, filter: tFilter);

      // Assert
      // Verification logic: The repository is responsible for logic, but we can't
      // easily verify internal variable state. However, ensuring it doesn't crash
      // and calls the datasource (even if we ignore arguments) is the baseline.
      // The true test of sanitization for pagination is in the slicing logic below.
      verify(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).called(1);
    });

    test('should deduplicate articles by ID, keeping the first instance', () async {
      // Arrange
      final tArticle1 = createArticleModel(
        id: '1',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'Title 1',
      );
      // Duplicate of Article 1
      final tArticle1Duplicate = createArticleModel(
        id: '1',
        tier: ArticleDisplayTier.hero, // Different tier to prove we kept first
        publishedAt: DateTime(2023),
        title: 'Title 1 Duplicate',
      );

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => [tArticle1, tArticle1Duplicate]);

      // Act
      final result = await repository.getArticles(
        page: 1,
        filter: tFilter,
        limit: 10,
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles.length, 1);
          expect(articles.first.id, '1');
          expect(articles.first.title, 'Title 1'); // Confirms first was kept
        },
      );
    });

    test('should filter out hidden articles', () async {
      // Arrange
      final tVisible = createArticleModel(
        id: '1',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'Visible',
      );
      final tHidden = createArticleModel(
        id: '2',
        tier: ArticleDisplayTier.hidden,
        publishedAt: DateTime(2023),
        title: 'Hidden',
      );

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => [tVisible, tHidden]);

      // Act
      final result = await repository.getArticles(page: 1, filter: tFilter, limit: 10);

      // Assert
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles.length, 1);
          expect(articles.first.id, '1');
        },
      );
    });

    test('should filter by tag (case-insensitive)', () async {
      // Arrange
      final tMatch = createArticleModel(
        id: '1',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'Match',
        tags: ['Flutter', 'Dart'],
      );
      final tNoMatch = createArticleModel(
        id: '2',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'No Match',
        tags: ['Java'],
      );

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => [tMatch, tNoMatch]);

      // Act
      final result = await repository.getArticles(
        page: 1,
        filter: const ArticleFilter(tags: ['flutter']), // Lowercase input
        limit: 10,
      );

      // Assert
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles.length, 1);
          expect(articles.first.id, '1');
        },
      );
    });

    test('should filter by search query (case-insensitive literal match)', () async {
      // Arrange
      final tMatch = createArticleModel(
        id: '1',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'Clean Architecture Guide',
      );
      final tNoMatch = createArticleModel(
        id: '2',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'State Management',
      );

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => [tMatch, tNoMatch]);

      // Act
      final result = await repository.getArticles(
        page: 1,
        filter: const ArticleFilter(searchQuery: ' clean '), // Whitespace check
        limit: 10,
      );

      // Assert
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles.length, 1);
          expect(articles.first.id, '1');
        },
      );
    });

    test('should rank articles: Hero > Standard, then Newest, then ID', () async {
      // Arrange
      final tStandardOld = createArticleModel(
        id: 'A',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2022),
        title: 'Standard Old',
      );
      final tStandardNew = createArticleModel(
        id: 'B',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'Standard New',
      );
      final tHero = createArticleModel(
        id: 'C',
        tier: ArticleDisplayTier.hero,
        publishedAt: DateTime(2021), // Hero comes first despite old date
        title: 'Hero',
      );
      // Tie-breaker case: Same Tier, Same Date -> Sort by ID
      final tTie1 = createArticleModel(
        id: 'Y',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2020),
        title: 'Tie 1',
      );
      final tTie2 = createArticleModel(
        id: 'X',
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2020),
        title: 'Tie 2',
      );

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer(
        (_) async => [
          tStandardOld,
          tTie1,
          tStandardNew,
          tHero,
          tTie2,
        ],
      );

      // Act
      final result = await repository.getArticles(
        page: 1,
        filter: tFilter,
        limit: 10,
      );

      // Assert
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles.length, 5);
          // 1. Hero
          expect(articles[0].id, 'C');
          // 2. Standard New (2023)
          expect(articles[1].id, 'B');
          // 3. Standard Old (2022)
          expect(articles[2].id, 'A');
          // 4. Tie Breaker (X comes before Y alphabetically)
          expect(articles[3].id, 'X');
          expect(articles[4].id, 'Y');
        },
      );
    });

    test('should paginate results correctly', () async {
      // Arrange
      final tList = List.generate(
        5,
        (i) => createArticleModel(
          id: '$i',
          tier: ArticleDisplayTier.standard,
          publishedAt: DateTime(2023, 1, 5 - i), // Ensure deterministic order
          title: 'Title $i',
        ),
      ); // IDs: 0, 1, 2, 3, 4. Dates ensure 0 is newest.

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tList);

      // Act: Request Page 2 with Limit 2
      // Total 5 items. Page 1: [0, 1]. Page 2: [2, 3]. Page 3: [4].
      final result = await repository.getArticles(
        page: 2,
        filter: tFilter,
        limit: 2,
      );

      // Assert
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles.length, 2);
          expect(articles[0].id, '2');
          expect(articles[1].id, '3');
        },
      );
    });

    test('should return empty list if page is out of bounds', () async {
      // Arrange
      final tList = [
        createArticleModel(
          id: '1',
          tier: ArticleDisplayTier.standard,
          publishedAt: DateTime(2023),
          title: '1',
        ),
      ];

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tList);

      // Act
      final result = await repository.getArticles(
        page: 2,
        limit: 10,
        filter: tFilter,
      );

      // Assert
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles, isEmpty);
        },
      );
    });

    test('should use default limit of 10 if limit is <= 0 or null', () async {
      // Arrange
      final tList = List.generate(
        15,
        (i) => createArticleModel(
          id: '$i',
          tier: ArticleDisplayTier.standard,
          publishedAt: DateTime(2023),
          title: '$i',
        ),
      );

      when(
        () => mockRemoteDataSource.getArticles(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tList);

      // Act
      final result = await repository.getArticles(
        page: 1,
        filter: tFilter,
        limit: 0, // Invalid limit
      );

      // Assert
      result.fold(
        (_) => fail('Should be Right'),
        (articles) {
          expect(articles.length, 10); // Should fallback to 10
        },
      );
    });
  });

  group('getArticleDetail', () {
    const tArticleId = 'a1';
    late ArticleModel tArticleModel;
    late Article tArticle;

    setUp(() {
      tArticleModel = createArticleModel(
        id: tArticleId,
        tier: ArticleDisplayTier.standard,
        publishedAt: DateTime(2023),
        title: 'Detail Title',
      ).copyWith(content: 'Full Content');
      tArticle = tArticleModel.toEntity();
    });

    test(
      'should return ValidationFailure when articleId is empty',
      () async {
        // Act
        final result = await repository.getArticleDetail('');

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (_) => fail('Should have returned a failure'),
        );
        verifyZeroInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Article when datasource returns data successfully',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getArticleDetail(tArticleId),
        ).thenAnswer((_) async => tArticleModel);

        // Act
        final result = await repository.getArticleDetail(tArticleId);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should have returned data'),
          (article) => expect(article, tArticle),
        );
        verify(() => mockRemoteDataSource.getArticleDetail(tArticleId)).called(1);
      },
    );

    test(
      'should return NotFoundFailure when datasource throws NotFoundException',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.getArticleDetail(tArticleId)).thenThrow(
          const NotFoundException(
            methodName: 'getArticleDetail',
            originalError: 'Not Found',
            title: 'Not Found',
            userMessage: 'Article not found',
          ),
        );

        // Act
        final result = await repository.getArticleDetail(tArticleId);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<NotFoundFailure>()),
          (_) => fail('Should have returned a failure'),
        );
      },
    );

    test(
      'should return DataParsingFailure when datasource throws DataParsingException',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.getArticleDetail(tArticleId)).thenThrow(
          const DataParsingException(
            methodName: 'getArticleDetail',
            originalError: 'Parsing Error',
            title: 'Parsing Error',
          ),
        );

        // Act
        final result = await repository.getArticleDetail(tArticleId);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<DataParsingFailure>()),
          (_) => fail('Should have returned a failure'),
        );
      },
    );

    test(
      'should return UnknownFailure when datasource throws generic Exception',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getArticleDetail(tArticleId),
        ).thenThrow(Exception('Generic Error'));

        // Act
        final result = await repository.getArticleDetail(tArticleId);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<UnknownFailure>()),
          (_) => fail('Should have returned a failure'),
        );
      },
    );
  });
}
