import 'package:equatable/equatable.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/articles/domain/entities/article.dart';

sealed class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object?> get props => [];
}

final class ArticlesInitialState extends ArticlesState {}

final class ArticlesLoadingState extends ArticlesState {}

final class ArticlesListSuccessState extends ArticlesState {
  const ArticlesListSuccessState({required this.articles});

  final List<Article> articles;

  @override
  List<Object?> get props => [articles];
}

final class ArticleDetailSuccessState extends ArticlesState {
  const ArticleDetailSuccessState({required this.article});

  final Article article;

  @override
  List<Object?> get props => [article];
}

final class ArticlesFailureState extends ArticlesState {
  const ArticlesFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
