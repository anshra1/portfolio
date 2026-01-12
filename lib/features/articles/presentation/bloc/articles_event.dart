import 'package:equatable/equatable.dart';
import 'package:portfolio/features/articles/domain/entities/article_filter.dart';

sealed class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object?> get props => [];
}

final class ArticlesListRequestedEvent extends ArticlesEvent {
  const ArticlesListRequestedEvent({
    required this.page,
    required this.filter,
    this.limit,
  });

  final int page;
  final ArticleFilter filter;
  final int? limit;

  @override
  List<Object?> get props => [page, filter, limit];
}

final class ArticleDetailRequestedEvent extends ArticlesEvent {
  const ArticleDetailRequestedEvent({required this.articleId});

  final String articleId;

  @override
  List<Object?> get props => [articleId];
}
