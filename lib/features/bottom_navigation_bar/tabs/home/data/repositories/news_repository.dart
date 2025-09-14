// lib/features/home/data/repositories/news_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsRepository {
  final String _baseUrl = "https://newsapi.org/v2";
  final String _apiKey = "0e43082b33eb41a6805d74a1a2776f78";

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await http
          .get(
            Uri.parse(
              "$_baseUrl/top-headlines?country=us&pageSize=30&apiKey=$_apiKey",
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List articles = data["articles"] ?? [];

        final validArticles = articles
            .where(
              (article) =>
                  article["title"] != null &&
                  article["title"].toString().trim().isNotEmpty &&
                  article["description"] != null &&
                  article["description"].toString().trim().isNotEmpty,
            )
            .toList();

        return validArticles.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }

  Future<List<NewsModel>> searchNews(String query) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              "$_baseUrl/everything?q=$query&pageSize=30&sortBy=publishedAt&language=en&apiKey=$_apiKey",
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List articles = data["articles"] ?? [];

        final validArticles = articles
            .where(
              (article) =>
                  article["title"] != null &&
                  article["title"].toString().trim().isNotEmpty &&
                  article["description"] != null &&
                  article["description"].toString().trim().isNotEmpty,
            )
            .toList();

        return validArticles.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to search news: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Search error: ${e.toString()}");
    }
  }

  Future<List<NewsModel>> fetchNewsByCategory(String category) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              "$_baseUrl/top-headlines?category=$category&pageSize=30&apiKey=$_apiKey",
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List articles = data["articles"] ?? [];

        final validArticles = articles
            .where(
              (article) =>
                  article["title"] != null &&
                  article["title"].toString().trim().isNotEmpty &&
                  article["description"] != null &&
                  article["description"].toString().trim().isNotEmpty,
            )
            .toList();

        return validArticles.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load category news: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Category fetch error: ${e.toString()}");
    }
  }
}
