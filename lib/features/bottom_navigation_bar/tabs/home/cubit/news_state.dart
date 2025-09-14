import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/data/models/news_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> articles;
  NewsLoaded(this.articles);
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
