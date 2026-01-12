import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/articles/domain/usecases/article_usecases.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_event.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({
    required GetArticles getArticles,
    required GetArticleDetail getArticleDetail,
  })  : _getArticles = getArticles,
        _getArticleDetail = getArticleDetail,
        super(ArticlesInitialState()) {
    on<ArticlesListRequestedEvent>(_onListRequested);
    on<ArticleDetailRequestedEvent>(_onDetailRequested);
  }

  final GetArticles _getArticles;
  final GetArticleDetail _getArticleDetail;

  Future<void> _onListRequested(
    ArticlesListRequestedEvent event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(ArticlesLoadingState());

    final result = await _getArticles(
      GetArticlesParams(
        page: event.page,
        filter: event.filter,
        limit: event.limit,
      ),
    );

    result.fold(
      (failure) => emit(ArticlesFailureState(failure: failure)),
      (articles) => emit(ArticlesListSuccessState(articles: articles)),
    );
  }

  Future<void> _onDetailRequested(
    ArticleDetailRequestedEvent event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(ArticlesLoadingState());

    final result = await _getArticleDetail(event.articleId);

    result.fold(
      (failure) => emit(ArticlesFailureState(failure: failure)),
      (article) => emit(ArticleDetailSuccessState(article: article)),
    );
  }
}
