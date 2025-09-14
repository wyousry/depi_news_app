
import '../../home/data/models/news_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<NewsModel> news;
  SearchLoaded(this.news);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
class SearchEmpty extends SearchState {}
class SearchRecent extends SearchState {
  final List<String> recent;
  SearchRecent(this.recent);
}