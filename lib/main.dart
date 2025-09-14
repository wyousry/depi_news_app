import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/data/repositories/news_repository.dart';
import 'package:depi_news_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
   runApp(
    RepositoryProvider(
      create: (_) => NewsRepository(),
      child: const MyApp(),
    ),
  );
}

