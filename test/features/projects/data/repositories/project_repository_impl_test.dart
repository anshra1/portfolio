import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/data/models/project_model.dart';
import 'package:portfolio/features/projects/data/repositories/project_repository_impl.dart';
import 'package:portfolio/features/projects/domain/entities/display_tier.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';

class MockProjectsRemoteDataSource extends Mock implements ProjectsRemoteDataSource {}

class FakeProjectFilterModel extends Fake implements ProjectFilterModel {}

void main() {
  late ProjectRepositoryImpl repository;
  late MockProjectsRemoteDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(FakeProjectFilterModel());
  });

  setUp(() {
    mockDataSource = MockProjectsRemoteDataSource();
    repository = ProjectRepositoryImpl(mockDataSource);
  });

  // Data Constants
  final tDate2024 = DateTime(2024);
  final tDate2023 = DateTime(2023);
  final tDate2022 = DateTime(2022);

  // Helper to create models
  ProjectModel createModel({
    required String id,
    required DisplayTier tier,
    required DateTime date,
    required String title,
    List<String> techs = const [],
    String description = 'Desc',
  }) {
    return ProjectModel(
      id: id,
      displayTier: tier,
      publishedAt: date,
      title: title,
      tagline: 'Tagline',
      typeIcon: 'icon',
      coverImageAsset: 'assets/image.png',
      sourceUrl: 'https://github.com',
      description: description,
      technologies: techs,
      downloads: [],
      features: [],
    );
  }

  group('getProjectDetail', () {
    const tProjectId = 'p1';
    final tProjectModel = createModel(
      id: tProjectId,
      tier: DisplayTier.hero,
      date: tDate2024,
      title: 'Project 1',
    );
    final tProject = tProjectModel.toEntity();

    test(
      'REP-DET-001: should return ValidationFailure when projectId is empty',
      () async {
        // Act
        final result = await repository.getProjectDetail('');

        // Assert
        expect(
          result,
          equals(
            left<Failure, dynamic>(
              const ValidationFailure(
                message: 'Project ID cannot be empty',
                title: 'Invalid Input',
              ),
            ),
          ),
        );
        verifyZeroInteractions(mockDataSource);
      },
    );

    test(
      'REP-DET-003: should return Project when datasource returns valid data',
      () async {
        // Arrange
        when(
          () => mockDataSource.getProjectDetail(tProjectId),
        ).thenAnswer((_) async => tProjectModel);

        // Act
        final result = await repository.getProjectDetail(tProjectId);

        // Assert
        expect(result, right<Failure, dynamic>(tProject));
        verify(() => mockDataSource.getProjectDetail(tProjectId)).called(1);
      },
    );

    test(
      'REP-DET-005: should return NotFoundFailure when datasource '
      'throws NotFoundException',
      () async {
        // Arrange
        when(() => mockDataSource.getProjectDetail(tProjectId)).thenThrow(
          const NotFoundException(
            methodName: 'getProjectDetail',
            originalError: 'Not found',
            title: 'Not Found',
          ),
        );

        // Act
        final result = await repository.getProjectDetail(tProjectId);

        // Assert
        expect(
          result,
          equals(
            left<Failure, dynamic>(
              const NotFoundFailure(
                message: 'Resource not found',
                title: 'Not Found',
              ),
            ),
          ),
        );
      },
    );

    test(
      'REP-DET-006: should return DataParsingFailure when datasource '
      'throws DataParsingException',
      () async {
        // Arrange
        when(() => mockDataSource.getProjectDetail(tProjectId)).thenThrow(
          const DataParsingException(
            methodName: 'getProjectDetail',
            originalError: 'Parsing error',
            title: 'Parsing Error',
          ),
        );

        // Act
        final result = await repository.getProjectDetail(tProjectId);

        // Assert
        expect(
          result,
          equals(
            left<Failure, dynamic>(
              const DataParsingFailure(
                message: 'Failed to parse data',
                title: 'Parsing Error',
              ),
            ),
          ),
        );
      },
    );

    test(
      'REP-DET-007: should return UnknownFailure when datasource '
      'throws generic Exception',
      () async {
        // Arrange
        when(
          () => mockDataSource.getProjectDetail(tProjectId),
        ).thenThrow(Exception('Generic error'));

        // Act
        final result = await repository.getProjectDetail(tProjectId);

        // Assert
        expect(
          result,
          isA<Left<Failure, dynamic>>().having(
            (l) => l.value,
            'value',
            isA<UnknownFailure>(),
          ),
        );
      },
    );
  });

  group('getProjects', () {
    // Dataset for filtering/sorting tests
    // 1. Hero, 2024
    final p1Hero = createModel(
      id: 'p1',
      tier: DisplayTier.hero,
      date: tDate2024,
      title: 'Hero Project',
      techs: ['Flutter', 'Dart'],
    );
    // 2. Showcase, 2023
    final p2Showcase = createModel(
      id: 'p2',
      tier: DisplayTier.showcase,
      date: tDate2023,
      title: 'Showcase Project',
      techs: ['React'],
    );
    // 3. Standard, 2022, ID: A_Project (for tie-break)
    final p3StandardA = createModel(
      id: 'A_Project',
      tier: DisplayTier.standard,
      date: tDate2022,
      title: 'Standard A',
      techs: ['Flutter'],
    );
    // 4. Standard, 2022, ID: B_Project (for tie-break)
    final p4StandardB = createModel(
      id: 'B_Project',
      tier: DisplayTier.standard,
      date: tDate2022, // Same date as A
      title: 'Standard B',
    );
    // 5. Hidden, 2025 (Newest but hidden)
    final p5Hidden = createModel(
      id: 'p5',
      tier: DisplayTier.hidden,
      date: DateTime(2025),
      title: 'Hidden',
    );

    final tFullList = [p3StandardA, p1Hero, p5Hidden, p4StandardB, p2Showcase];

    // Mocks the datasource to return the full unsorted list
    void mockFullList() {
      when(
        () => mockDataSource.getProjects(
          page: any(named: 'page'),
          filter: any(named: 'filter'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => tFullList);
    }

    test(
      'REP-001: should sanitize inputs and use defaults (page 1, limit 6) '
      'when inputs invalid',
      () async {
        // Arrange
        mockFullList();
        // Request invalid page -1
        const page = -1;
        const limit = 0; // Invalid limit
        const filter = ProjectFilter();

        // Act
        final result = await repository.getProjects(
          page: page,
          limit: limit,
          filter: filter,
        );

        // Assert
        // Logic:
        // 1. Filter out hidden (p5) -> [p3, p1, p4, p2]
        // 2. Sort Tier: Hero(p1), Showcase(p2), Standard(p3, p4)
        // 3. Sort Date/ID: p1, p2, p3(A), p4(B)
        // 4. Page 1, Limit 6 -> Returns all 4
        expect(result.isRight(), true);
        final list = result.getOrElse(() => <Project>[]);
        expect(list.length, 4);
        expect(list[0].id, p1Hero.id);
      },
    );

    test(
      'REP-002: should filter out Hidden projects',
      () async {
        // Arrange
        mockFullList();

        // Act
        final result = await repository.getProjects(
          page: 1,
          filter: const ProjectFilter(),
        );

        // Assert
        final list = result.getOrElse(() => <Project>[]);
        expect(list.any((Project p) => p.displayTier == DisplayTier.hidden), false);
        expect(
          list.map((Project p) => p.id),
          containsAll(['p1', 'p2', 'A_Project', 'B_Project']),
        );
      },
    );

    test(
      'REP-003: should filter by Technology (case-insensitive)',
      () async {
        // Arrange
        mockFullList();
        // 'flutter' should match p1Hero (Flutter) and p3StandardA (Flutter)
        // p2Showcase is React. p4 has none.
        const filter = ProjectFilter(technology: 'flutter');

        // Act
        final result = await repository.getProjects(
          page: 1,
          filter: filter,
        );

        // Assert
        final list = result.getOrElse(() => <Project>[]);
        expect(list.length, 2);
        expect(list.map((Project p) => p.id), containsAll(['p1', 'A_Project']));
      },
    );

    test(
      'REP-004: should filter by Search Query and ignore noise',
      () async {
        // Arrange
        mockFullList();
        // Query "  hero  " should match "Hero Project"
        const filter = ProjectFilter(searchQuery: '  hero  ');

        // Act
        final result = await repository.getProjects(
          page: 1,
          filter: filter,
        );

        // Assert
        final list = result.getOrElse(() => <Project>[]);
        expect(list.length, 1);
        expect(list.first.id, 'p1');
      },
    );

    test(
      'REP-005, REP-006: should apply Tier-Preserving Sort and '
      'Deterministic Tie-Breaking',
      () async {
        // Arrange
        mockFullList();
        // Input order: StandardA, Hero, Hidden, StandardB, Showcase
        // Expected Order:
        // 1. Hero (p1)
        // 2. Showcase (p2)
        // 3. Standard A (p3) - Tie break A vs B
        // 4. Standard B (p4)
        const filter = ProjectFilter(); // Default sort: Newest

        // Act
        final result = await repository.getProjects(
          page: 1,
          filter: filter,
        );

        // Assert
        final list = result.getOrElse(() => <Project>[]);
        expect(list.length, 4);
        expect(list[0].id, 'p1'); // Hero
        expect(list[1].id, 'p2'); // Showcase
        expect(list[2].id, 'A_Project'); // Standard (Tie-break ID 'A' < 'B')
        expect(list[3].id, 'B_Project'); // Standard
      },
    );

    test(
      'REP-007: should paginate results correctly (Slice)',
      () async {
        // Arrange
        mockFullList();
        // Sorted List: [p1, p2, p3, p4]
        // Request Page 2, Limit 2
        // Page 1: p1, p2
        // Page 2: p3, p4

        // Act
        final result = await repository.getProjects(
          page: 2,
          limit: 2,
          filter: const ProjectFilter(),
        );

        // Assert
        final list = result.getOrElse(() => <Project>[]);
        expect(list.length, 2);
        expect(list[0].id, 'A_Project'); // p3
        expect(list[1].id, 'B_Project'); // p4
      },
    );

    test(
      'REP-008: should return empty list when pagination is out of bounds',
      () async {
        // Arrange
        mockFullList();
        // Total filtered items: 4
        // Request Page 2, Limit 10 -> Start Index 10 (> 4)

        // Act
        final result = await repository.getProjects(
          page: 2,
          limit: 10,
          filter: const ProjectFilter(),
        );

        // Assert
        final list = result.getOrElse(() => <Project>[]);
        expect(list, isEmpty);
      },
    );

    test(
      'REP-009: should map Datasource Exception to Failure',
      () async {
        // Arrange
        when(
          () => mockDataSource.getProjects(
            page: any(named: 'page'),
            filter: any(named: 'filter'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(
          const DataParsingException(
            methodName: 'getProjects',
            originalError: 'Error',
            title: 'Error',
          ),
        );

        // Act
        final result = await repository.getProjects(
          page: 1,
          filter: const ProjectFilter(),
        );

        // Assert
        expect(
          result,
          equals(
            left<Failure, dynamic>(
              const DataParsingFailure(
                message: 'Failed to parse data',
                title: 'Error',
              ),
            ),
          ),
        );
      },
    );
  });
}
