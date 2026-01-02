import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:portfolio/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/data/models/project_model.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

class MockTalkerService extends Mock implements TalkerService {}

void main() {
  late ProjectsRemoteDataSourceImpl dataSource;
  late MockAssetBundle mockAssetBundle;
  late MockTalkerService mockTalkerService;
  late Faker faker;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    mockTalkerService = MockTalkerService();
    faker = Faker();
    dataSource = ProjectsRemoteDataSourceImpl(
      assetBundle: mockAssetBundle,
      talkerService: mockTalkerService,
    );
  });

  const tProjectsJsonPath = 'assets/data/projects.json';

  // Helper to generate a valid Project JSON object string
  String generateValidProjectJson({
    String? id,
    String? title,
    String displayTier = 'hero',
  }) {
    return '''
    {
      "id": "${id ?? 'p1'}",
      "displayTier": "$displayTier",
      "publishedAt": "2023-01-01T00:00:00.000Z",
      "title": "${title ?? 'Test Project'}",
      "tagline": "A test project",
      "typeIcon": "code",
      "coverImageAsset": "assets/img.png",
      "sourceUrl": "https://example.com",
      "description": "Description",
      "technologies": ["Flutter", "Dart"],
      "downloads": [],
      "features": []
    }
    ''';
  }

  group('getProjectDetail', () {
    const tProjectId = 'p1';

    test(
      'should return ProjectModel when JSON contains the project with valid ID [DS-DET-001]',
      () async {
        // Arrange
        final tJson = '[${generateValidProjectJson(id: tProjectId)}]';
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tJson);

        // Act
        final result = await dataSource.getProjectDetail(tProjectId);

        // Assert
        expect(result, isA<ProjectModel>());
        expect(result.id, equals(tProjectId));
        verify(() => mockAssetBundle.loadString(tProjectsJsonPath)).called(1);
      },
    );

    test(
      'should throw NotFoundException when project ID does not exist in the list [DS-DET-002]',
      () async {
        // Arrange
        final tJson = '[${generateValidProjectJson(id: "other_id")}]';
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tJson);

        // Act
        final call = dataSource.getProjectDetail;

        // Assert
        expect(
          () => call(tProjectId),
          throwsA(isA<NotFoundException>()),
        );
      },
    );

    test(
      'should throw DataParsingException when asset file is missing [DS-DET-003]',
      () async {
        // Arrange
        when(() => mockAssetBundle.loadString(tProjectsJsonPath)).thenThrow(
          const FileSystemException(
            methodName: 'loadString',
            originalError: 'File not found',
            userMessage: 'File not found',
            title: 'File System Error',
          ),
        );

        // Act
        final call = dataSource.getProjectDetail;

        // Assert
        expect(
          () => call(tProjectId),
          throwsA(isA<DataParsingException>()),
        );
      },
    );

    test(
      'should throw DataParsingException when JSON is malformed [DS-DET-004]',
      () async {
        // Arrange
        const tMalformedJson = '{ "id": "p1", "title": '; // Missing value/brace
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tMalformedJson);

        // Act
        final call = dataSource.getProjectDetail;

        // Assert
        expect(
          () => call(tProjectId),
          throwsA(isA<DataParsingException>()),
        );
      },
    );

    test(
      'should throw DataParsingException when mandatory fields are missing [DS-DET-005]',
      () async {
        // Arrange
        // Missing "title"
        const tInvalidJson =
            '''
        [{
          "id": "$tProjectId",
          "displayTier": "hero",
          "publishedAt": "2023-01-01T00:00:00.000Z",
          "tagline": "Missing Title",
          "typeIcon": "code",
          "coverImageAsset": "assets/img.png",
          "sourceUrl": "https://example.com",
          "description": "Description",
          "technologies": []
        }]
        ''';
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tInvalidJson);

        // Act
        final call = dataSource.getProjectDetail;

        // Assert
        expect(
          () => call(tProjectId),
          throwsA(isA<DataParsingException>()),
        );
      },
    );
  });

  group('getProjects', () {
    const tPage = 1;
    const tFilter = ProjectFilterModel();

    test(
      'should return a list of ProjectModels when JSON is valid [DS-001]',
      () async {
        // Arrange
        final tJson =
            '[${generateValidProjectJson(id: 'p1')}, ${generateValidProjectJson(id: 'p2')}]';
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tJson);

        // Act
        final result = await dataSource.getProjects(page: tPage, filter: tFilter);

        // Assert
        expect(result, isA<List<ProjectModel>>());
        expect(result.length, equals(2));
        expect(result.first.id, equals('p1'));
        expect(result.last.id, equals('p2'));
      },
    );

    test(
      'should throw DataParsingException when asset file is missing [DS-002]',
      () async {
        // Arrange
        when(() => mockAssetBundle.loadString(tProjectsJsonPath)).thenThrow(
          const FileSystemException(
            methodName: 'loadString',
            originalError: 'File not found',
            userMessage: 'File not found',
            title: 'File System Error',
          ),
        );

        // Act
        final call = dataSource.getProjects;

        // Assert
        expect(
          () => call(page: tPage, filter: tFilter),
          throwsA(isA<DataParsingException>()),
        );
      },
    );

    test(
      'should throw DataParsingException when JSON syntax is corrupt [DS-003]',
      () async {
        // Arrange
        const tMalformedJson = '[{ "id": "p1" '; // Missing closing brace/bracket
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tMalformedJson);

        // Act
        final call = dataSource.getProjects;

        // Assert
        expect(
          () => call(page: tPage, filter: tFilter),
          throwsA(isA<DataParsingException>()),
        );
      },
    );

    test(
      'should skip invalid records and return valid subset (Valid-Subset Recovery) [DS-004]',
      () async {
        // Arrange
        // Item 1: Valid. Item 2: Missing title. Item 3: Valid.
        final tMixedJson =
            '''
        [
          ${generateValidProjectJson(id: 'p1')},
          {
            "id": "p2",
            "displayTier": "hero",
            "publishedAt": "2023-01-01T00:00:00.000Z",
             "tagline": "Missing Title", 
             "typeIcon": "code",
             "coverImageAsset": "img.png",
             "sourceUrl": "url",
             "description": "desc",
             "technologies": []
          },
          ${generateValidProjectJson(id: 'p3')}
        ]
        ''';
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tMixedJson);

        // Mock Talker to prevent crash on log
        when(() => mockTalkerService.warning(any())).thenReturn(null);

        // Act
        final result = await dataSource.getProjects(page: tPage, filter: tFilter);

        // Assert
        expect(result.length, equals(2));
        expect(result[0].id, equals('p1'));
        expect(result[1].id, equals('p3'));
      },
    );

    test(
      'should log a warning when a record is skipped due to schema violation [DS-005]',
      () async {
        // Arrange
        // Item 1: Invalid (Missing title).
        const tInvalidRecordJson = '''
        [{
            "id": "p2",
            "displayTier": "hero",
            "publishedAt": "2023-01-01T00:00:00.000Z",
             "tagline": "Missing Title", 
             "typeIcon": "code",
             "coverImageAsset": "img.png",
             "sourceUrl": "url",
             "description": "desc",
             "technologies": []
        }]
        ''';
        when(
          () => mockAssetBundle.loadString(tProjectsJsonPath),
        ).thenAnswer((_) async => tInvalidRecordJson);
        when(() => mockTalkerService.warning(any())).thenReturn(null);

        // Act
        await dataSource.getProjects(page: tPage, filter: tFilter);

        // Assert
        verify(() => mockTalkerService.warning(any())).called(1);
      },
    );
  });
}
