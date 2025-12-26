//
// ignore_for_file: one_member_abstracts, lines_longer_than_80_chars

import 'package:portfolio/core/common/typedefs.dart';

abstract class FutureUseCaseWithParams<T, P> {
  const FutureUseCaseWithParams();
  ResultFuture<T> call(P params);
}

abstract class FutureUseCaseWithoutParams<T> {
  const FutureUseCaseWithoutParams();
  ResultFuture<T> call();
}

abstract class StreamUseCaseWithoutParam<T> {
  const StreamUseCaseWithoutParam();
  ResultStream<T> call();
}

abstract class StreamUseCaseWithParams<T, P> {
  const StreamUseCaseWithParams();
  ResultStream<T> call(P params);
}

// examples of repository
/*
/// Open directory tree: scan directory + update recent workspaces + load settings
  ResultFuture<WorkspaceData> openDirectoryTree(String directoryPath);

  /// Get recent workspaces with validation
  ResultFuture<List<RecentWorkspace>> getRecentWorkspaces();

  /// Remove workspace from recent list
  ResultFuture<List<RecentWorkspace>> removeRecentWorkspace(String workspacePath);

  /// Toggle favorite state for a recent workspace
  ResultFuture<List<RecentWorkspace>> toggleFavoriteRecentWorkspace(String workspacePath);

  /// Clear all recent workspaces
  ResultFuture<List<RecentWorkspace>> clearRecentWorkspaces();

  */
