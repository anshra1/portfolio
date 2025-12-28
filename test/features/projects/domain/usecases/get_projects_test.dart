// Target Use Case: GetProjects
// Repository Method: getProjects

import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/projects/domain/entities/architecture_feature.dart';
import 'package:portfolio/features/projects/domain/entities/downloadable_artifact.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';
import 'package:portfolio/features/projects/domain/repositories/project_repository.dart';
import 'package:portfolio/features/projects/domain/usecases/project_usecase.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late GetProjects useCase;
  late MockProjectRepository mockRepository;

  final tProject = Project(
    id: faker.guid.guid(),
    isFeatured: faker.randomGenerator.boolean(),
    title: faker.lorem.words(3).join(' '),
    tagline: faker.lorem.sentence(),
    typeIcon: faker.lorem.word(),
    coverImageAsset: faker.internet.httpsUrl(),
    sourceUrl: faker.internet.httpsUrl(),
    description: faker.lorem.sentences(2).join(' '),
    technologies: faker.lorem.words(3),
    downloads: [
      DownloadableArtifact(
        platformName: faker.lorem.word(),
        version: '1.0.0',
        metaInfo: faker.lorem.sentence(),
        type: ArtifactType.binary,
        actionUrl: faker.internet.httpsUrl(),
      ),
    ],
    features: [
      ArchitectureFeature(
        title: faker.lorem.word(),
        description: faker.lorem.sentence(),
        icon: faker.lorem.word(),
      ),
    ],
  );

  final tProjects = [tProject];
  final tFilter = ProjectFilter(
    searchQuery: faker.lorem.word(),
    isFeatured: true,
  );
  final tParams = GetProjectsParams(page: 1, filter: tFilter, limit: 10);

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = GetProjects(mockRepository);
  });

  test('should return List<Project> when repository call is successful',
      () async {
    // Arrange
    when(
      () => mockRepository.getProjects(
        page: any(named: 'page'),
        filter: tFilter,
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) async => Right(tProjects));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, Right(tProjects));
    verify(
      () => mockRepository.getProjects(
        page: tParams.page,
        filter: tParams.filter,
        limit: tParams.limit,
      ),
    ).called(1);
  });

  test('should return Failure when repository call is unsuccessful', () async {
    // Arrange
    const tFailure = ServerFailure(message: 'Server Error', title: '');
    when(
      () => mockRepository.getProjects(
        page: any(named: 'page'),
        filter: tFilter,
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, const Left(tFailure));
    verify(
      () => mockRepository.getProjects(
        page: tParams.page,
        filter: tParams.filter,
        limit: tParams.limit,
      ),
    ).called(1);
  });
}