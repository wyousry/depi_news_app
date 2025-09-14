import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/news_repository.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository repository;

  NewsCubit(this.repository) : super(NewsInitial());

  Future<void> loadNews() async {
    emit(NewsLoading());
    try {
      final articles = await repository.fetchNews();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      loadNews();
      return;
    }
    
    emit(NewsLoading());
    try {
      final articles = await repository.searchNews(query);
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> refreshNews() async {
    try {
      final articles = await repository.fetchNews();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}