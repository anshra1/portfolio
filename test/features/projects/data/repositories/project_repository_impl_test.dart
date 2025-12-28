// PATH: test/features/projects/data/repositories/project_repository_impl_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/data/models/project_model.dart';
import 'package:portfolio/features/projects/data/repositories/project_repository_impl.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';

class MockProjectsRemoteDataSource extends Mock
        //
        implements
        ProjectsRemoteDataSource {}

void main() {
  late ProjectRepositoryImpl repository;
  late MockProjectsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProjectsRemoteDataSource();
    repository = ProjectRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    registerFallbackValue(
      const ProjectFilterModel(),
    );
  });

  const tProjectId = 'p1';
  const tProjectFilter = ProjectFilter(searchQuery: 'test');
  const tProjectFilterModel = ProjectFilterModel(searchQuery: 'test');

  const tProjectModel = ProjectModel(
    id: tProjectId,
    isFeatured: true,
    title: 'Test Project',
    tagline: 'Test Tagline',
    typeIcon: 'smartphone',
    coverImageAsset: 'assets/images/cover.jpg',
    sourceUrl: 'https://example.com',
    description: '<p>Description</p>',
    technologies: ['Flutter'],
  );

  final tProject = tProjectModel.toEntity();
  final tProjectListModel = [tProjectModel];
  final tProjectList = [tProject];

  const tServerException = ServerException(
    methodName: 'getProjects',
    originalError: 'Server Error',
    userMessage: 'Server Error',
    title: 'Server Error',
  );

  const tServerFailure = ServerFailure(
    message: 'Server Error',
    title: 'Server Error',
  );

  group('getProjects', () {
    test(
      'should return List<Project> when call to data source is successful (Transformation)',
      () async {
        // Arrange
        when( 
          () => mockRemoteDataSource.getProjects(
            page: any(named: 'page'),
            filter: any(named: 'filter'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => tProjectListModel);

        // Act
        final result = await repository.getProjects(
          page: 1,
          filter: tProjectFilter,
          limit: 10,
        );

        // Assert
        expect(result, Right<Failure,List<Project>>(tProjectList));
        verify(
          () => mockRemoteDataSource.getProjects(
            page: 1,
            filter: tProjectFilterModel,
          ),
        ).called(1);
      },
    );

    test(
      'should return ServerFailure when call to data source throws ServerException (Error Mapping)',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getProjects(
            page: any(named: 'page'),
            filter: any(named: 'filter'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(tServerException);

        // Act
        final result = await repository.getProjects(
          page: 1,
          filter: tProjectFilter,
        );

        // Assert
        expect(result, const Left(tServerFailure));
        verify(
          () => mockRemoteDataSource.getProjects(
            page: 1,
            filter: tProjectFilterModel,
          ),
        ).called(1);
      },
    );
  });

  group('getProjectDetail', () {
    test(
      'should return Project when call to data source is successful (Transformation)',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getProjectDetail(any()),
        ).thenAnswer((_) async => tProjectModel);

        // Act
        final result = await repository.getProjectDetail(tProjectId);

        // Assert
        expect(result, Right(tProject));
        verify(() => mockRemoteDataSource.getProjectDetail(tProjectId)).called(1);
      },
    );

    test(
      'should return ServerFailure when call to data source throws ServerException (Error Mapping)',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getProjectDetail(any()),
        ).thenThrow(tServerException);

        // Act
        final result = await repository.getProjectDetail(tProjectId);

        // Assert
        expect(result, const Left(tServerFailure));
        verify(() => mockRemoteDataSource.getProjectDetail(tProjectId)).called(1);
      },
    );
  });
}
