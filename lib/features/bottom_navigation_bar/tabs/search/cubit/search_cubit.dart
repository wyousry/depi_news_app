import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/data/repositories/news_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final NewsRepository newsRepository;
  List<String> recentSearches = [];

  SearchCubit(this.newsRepository) : super(SearchInitial()) {
    _loadRecentSearches();
  }

  Future<void> searchNews(String query,String language) async {
    if (query.isEmpty) {
      emit(SearchEmpty());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await newsRepository.searchNews(query, language);

      await _addRecentSearch(query);

      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchEmpty());
  }


  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches = prefs.getStringList('recent_searches') ?? [];
    emit(SearchInitial()); 
  }

  Future<void> _addRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();


    recentSearches.remove(query);
    recentSearches.insert(0, query);

    
    if (recentSearches.length > 5) {
      recentSearches = recentSearches.sublist(0, 5);
    }

    await prefs.setStringList('recent_searches', recentSearches);
  }
}
