// PATH: lib/features/projects/data/datasources/projects_remote_data_source.dart
// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/data/models/project_model.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModel>> getProjects({
    required int page,
    required ProjectFilterModel filter,
    int? limit,
  });

  Future<ProjectModel> getProjectDetail(String projectId);
}

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  ProjectsRemoteDataSourceImpl({
    required this.assetBundle,
    required this.talkerService,
  });

  final AssetBundle assetBundle;
  final TalkerService talkerService;

  @override
  Future<List<ProjectModel>> getProjects({
    required int page,
    required ProjectFilterModel filter,
    int? limit,
  }) async {
    try {
      final jsonString = await assetBundle.loadString('assets/data/projects.json');
      final jsonList = jsonDecode(jsonString) as List<dynamic>;

      final projects = <ProjectModel>[];
      for (final dynamic item in jsonList) {
        try {
          final projectMap = item as Map<String, dynamic>;
          // Step 4c: Schema Failure check (mandatory fields: id, title)
          if (!projectMap.containsKey('id') || !projectMap.containsKey('title')) {
            talkerService.warning('Skipping corrupt project record: missing id or title');
            continue;
          }
          projects.add(ProjectModel.fromJson(projectMap));
        } on Exception catch (e) {
          talkerService.warning('Skipping corrupt project record: $e');
        }
      }
      return projects;
    } on FormatException catch (e) {
      throw DataParsingException(
        methodName: 'getProjects',
        originalError: e.toString(),
        title: 'JSON Format Error',
        userMessage: 'Projects data is malformed',
      );
    } on Exception catch (e) {
      if (e is DataParsingException) rethrow;
      throw DataParsingException(
        methodName: 'getProjects',
        originalError: e.toString(),
        title: 'Unexpected Exception',
        userMessage: 'An error occurred while fetching projects',
      );
    }
  }

  @override
  Future<ProjectModel> getProjectDetail(String projectId) async {
    try {
      final jsonString = await assetBundle.loadString('assets/data/projects.json');
      final jsonList = jsonDecode(jsonString) as List<dynamic>;

      for (final dynamic item in jsonList) {
        final projectMap = item as Map<String, dynamic>;
        if (projectMap['id'] == projectId) {
          try {
            // Strict Serialization: if mandatory fields missing, throw DataParsingException
            return ProjectModel.fromJson(projectMap);
          } on Exception catch (e) {
            throw DataParsingException(
              methodName: 'getProjectDetail',
              originalError: e.toString(),
              title: 'Project Data Corruption',
              userMessage: 'Project record is invalid',
              context: {'projectId': projectId},
            );
          }
        }
      }

      throw NotFoundException(
        methodName: 'getProjectDetail',
        originalError: 'Project with ID $projectId not found',
        title: 'Project Not Found',
        userMessage: 'The requested project could not be found',
        context: {'projectId': projectId},
      );
    } on FormatException catch (e) {
      throw DataParsingException(
        methodName: 'getProjectDetail',
        originalError: e.toString(),
        title: 'JSON Format Error',
        userMessage: 'Projects data is malformed',
      );
    } on Exception catch (e) {
      if (e is DataParsingException || e is NotFoundException) rethrow;
      throw DataParsingException(
        methodName: 'getProjectDetail',
        originalError: e.toString(),
        title: 'Unexpected Exception',
        userMessage: 'An error occurred while fetching project details',
      );
    }
  }
}
