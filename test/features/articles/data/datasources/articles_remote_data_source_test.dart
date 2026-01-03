import 'dart:convert';
import 'dart:typed_data';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/articles/data/datasources/articles_remote_data_source.dart';
import 'package:portfolio/features/articles/data/models/article_model.dart';
import 'package:portfolio/features/articles/domain/entities/article_display_tier.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  late ArticlesRemoteDataSourceImpl dataSource;
  late MockAssetBundle mockAssetBundle;
  late Faker tFaker;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    dataSource = ArticlesRemoteDataSourceImpl(assetBundle: mockAssetBundle);
    tFaker = Faker.withGenerator(RandomGenerator(seed: 42));
  });

  group('getArticleDetail', () {
    final tId = tFaker.guid.guid();
    const tRegistryPath = 'database/articles/articles.json';
    final tContentPath = 'database/articles/content/$tId.md';
    const tContent = '# Test Content';

    final tArticleModel = ArticleModel(
      id: tId,
      displayTier: ArticleDisplayTier.standard,
      publishedAt: DateTime(2023),
      title: tFaker.lorem.sentence(),
      readTime: '5 min',
      summary: tFaker.lorem.sentence(),
      contentPath: tContentPath,
      tags: ['flutter'],
      coverImageAsset: 'assets/image.png',
    );

    final tRegistryJson = jsonEncode([
      {
        'id': tId,
        'displayTier': 'standard',
        'publishedAt': '2023-01-01T00:00:00.000Z',
        'title': tArticleModel.title,
        'readTime': '5 min',
        'summary': tArticleModel.summary,
        'contentPath': tContentPath,
        'tags': ['flutter'],
        'coverImageAsset': 'assets/image.png',
      }
    ]);

    ByteData _createByteData(String content) {
      final bytes = utf8.encode(content);
      return ByteData.sublistView(Uint8List.fromList(bytes));
    }

    void _mockRegistrySuccess() {
      when(() => mockAssetBundle.loadString(tRegistryPath))
          .thenAnswer((_) async => tRegistryJson);
    }

    void _mockContentSuccess([String content = tContent]) {
      when(() => mockAssetBundle.load(tContentPath))
          .thenAnswer((_) async => _createByteData(content));
    }

    test(
      'DS-ART-DET-001: should return hydrated ArticleModel on cold start (Cache Miss)',
      () async {
        // Arrange
        _mockRegistrySuccess();
        _mockContentSuccess();

        // Act
        final result = await dataSource.getArticleDetail(tId);

        // Assert
        expect(result.id, tId);
        expect(result.content, tContent);
        verify(() => mockAssetBundle.loadString(tRegistryPath)).called(1);
        verify(() => mockAssetBundle.load(tContentPath)).called(1);
      },
    );

    test(
      'DS-ART-DET-002: should return ArticleModel from cache and only read content file (Cache Hit)',
      () async {
        // Arrange
        _mockRegistrySuccess();
        _mockContentSuccess();
        // First call to populate cache
        await dataSource.getArticleDetail(tId);

        // Act
        final result = await dataSource.getArticleDetail(tId);

        // Assert
        expect(result.id, tId);
        expect(result.content, tContent);
        // loadString should still be called only once across both calls
        verify(() => mockAssetBundle.loadString(tRegistryPath)).called(1);
        verify(() => mockAssetBundle.load(tContentPath)).called(2);
      },
    );

    test(
      'DS-ART-DET-003: should parse registry exactly once during concurrent initialization',
      () async {
        // Arrange
        when(() => mockAssetBundle.loadString(tRegistryPath))
            .thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return tRegistryJson;
        });
        _mockContentSuccess();

        // Act
        final results = await Future.wait([
          dataSource.getArticleDetail(tId),
          dataSource.getArticleDetail(tId),
        ]);

        // Assert
        expect(results[0].id, tId);
        expect(results[1].id, tId);
        verify(() => mockAssetBundle.loadString(tRegistryPath)).called(1);
      },
    );

    test(
      'DS-ART-DET-004: should throw NotFoundException when target ID is not in registry',
      () async {
        // Arrange
        _mockRegistrySuccess();

        // Act
        final call = dataSource.getArticleDetail('unknown');

        // Assert
        expect(() => call, throwsA(isA<NotFoundException>()));
      },
    );

    test(
      'DS-ART-DET-005: should throw DataParsingException when registry record misses contentPath',
      () async {
        // Arrange
        final corruptRegistry = jsonEncode([
          {
            'id': tId,
            'displayTier': 'standard',
            'publishedAt': '2023-01-01T00:00:00.000Z',
            'title': 'Corrupt',
            'readTime': '5 min',
            'summary': 'Summary',
            // Missing contentPath
            'tags': [],
            'coverImageAsset': 'asset',
          }
        ]);
        when(() => mockAssetBundle.loadString(tRegistryPath))
            .thenAnswer((_) async => corruptRegistry);

        // Act
        final call = dataSource.getArticleDetail(tId);

        // Assert
        expect(() => call, throwsA(isA<DataParsingException>()));
      },
    );

    test(
      'DS-ART-DET-006: should throw DataParsingException on path traversal attack (relative path)',
      () async {
        // Arrange
        final maliciousPath = 'database/articles/content/../../secret.txt';
        final maliciousRegistry = jsonEncode([
          {
            'id': tId,
            'displayTier': 'standard',
            'publishedAt': '2023-01-01T00:00:00.000Z',
            'title': 'Attack',
            'readTime': '5 min',
            'summary': 'Summary',
            'contentPath': maliciousPath,
            'tags': [],
            'coverImageAsset': 'asset',
          }
        ]);
        when(() => mockAssetBundle.loadString(tRegistryPath))
            .thenAnswer((_) async => maliciousRegistry);

        // Act
        final call = dataSource.getArticleDetail(tId);

        // Assert
        expect(() => call, throwsA(isA<DataParsingException>()));
        verifyNever(() => mockAssetBundle.load(any()));
      },
    );

    test(
      'DS-ART-DET-007: should throw DataParsingException on path traversal attack (invalid prefix)',
      () async {
        // Arrange
        const maliciousPath = 'lib/main.dart';
        final maliciousRegistry = jsonEncode([
          {
            'id': tId,
            'displayTier': 'standard',
            'publishedAt': '2023-01-01T00:00:00.000Z',
            'title': 'Attack',
            'readTime': '5 min',
            'summary': 'Summary',
            'contentPath': maliciousPath,
            'tags': [],
            'coverImageAsset': 'asset',
          }
        ]);
        when(() => mockAssetBundle.loadString(tRegistryPath))
            .thenAnswer((_) async => maliciousRegistry);

        // Act
        final call = dataSource.getArticleDetail(tId);

        // Assert
        expect(() => call, throwsA(isA<DataParsingException>()));
        verifyNever(() => mockAssetBundle.load(any()));
      },
    );

    test(
      'DS-ART-DET-008: should throw DataParsingException when content file exceeds 5MB',
      () async {
        // Arrange
        _mockRegistrySuccess();
        final oversizedBytes = Uint8List(5 * 1024 * 1024 + 1);
        when(() => mockAssetBundle.load(tContentPath))
            .thenAnswer((_) async => ByteData.sublistView(oversizedBytes));

        // Act
        final call = dataSource.getArticleDetail(tId);

        // Assert
        expect(() => call, throwsA(isA<DataParsingException>()));
      },
    );

    test(
      'DS-ART-DET-009: should throw DataParsingException on non-UTF8 content encoding',
      () async {
        // Arrange
        _mockRegistrySuccess();
        final invalidBytes = Uint8List.fromList([0xFF, 0xFE, 0xFD]);
        when(() => mockAssetBundle.load(tContentPath))
            .thenAnswer((_) async => ByteData.sublistView(invalidBytes));

        // Act
        final call = dataSource.getArticleDetail(tId);

        // Assert
        expect(() => call, throwsA(isA<DataParsingException>()));
      },
    );

    test(
      'DS-ART-DET-010: should throw DataParsingException when content file is missing (orphaned entry)',
      () async {
        // Arrange
        _mockRegistrySuccess();
        when(() => mockAssetBundle.load(tContentPath))
            .thenThrow(FlutterError('Asset not found'));

        // Act
        final call = dataSource.getArticleDetail(tId);

        // Assert
        expect(() => call, throwsA(isA<DataParsingException>()));
      },
    );

    test(
      'DS-ART-DET-011: should return ArticleModel with empty content when file is 0 bytes',
      () async {
        // Arrange
        _mockRegistrySuccess();
        when(() => mockAssetBundle.load(tContentPath))
            .thenAnswer((_) async => ByteData(0));

        // Act
        final result = await dataSource.getArticleDetail(tId);

        // Assert
        expect(result.id, tId);
        expect(result.content, '');
      },
    );
  });
}
