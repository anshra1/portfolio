// Target Use Case: GetProjectDetail
// Repository Method: getProjectDetail

import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/projects/domain/entities/architecture_feature.dart';
import 'package:portfolio/features/projects/domain/entities/display_tier.dart';
import 'package:portfolio/features/projects/domain/entities/downloadable_artifact.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/repositories/project_repository.dart';
import 'package:portfolio/features/projects/domain/usecases/project_usecase.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late GetProjectDetail useCase;
  late MockProjectRepository mockRepository;

  final tProject = Project(
    id: faker.guid.guid(),
    displayTier: DisplayTier.hero,
    publishedAt: DateTime.now(),
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

  final tId = tProject.id;

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = GetProjectDetail(mockRepository);
  });

  test('should return Project when repository call is successful', () async {
    // Arrange
    when(
      () => mockRepository.getProjectDetail(tId),
    ).thenAnswer((_) async => Right(tProject));

    // Act
    final result = await useCase(tId);

    // Assert
    expect(result, Right<Failure, Project>(tProject));
    verify(() => mockRepository.getProjectDetail(tId)).called(1);
  });

  test('should return Failure when repository call is unsuccessful', () async {
    // Arrange
    const tFailure = ServerFailure(message: 'Server Error', title: '');
    when(
      () => mockRepository.getProjectDetail(tId),
    ).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(tId);

    // Assert
    expect(result, const Left<Failure, Project>(tFailure));
    verify(() => mockRepository.getProjectDetail(tId)).called(1);
  });
}
