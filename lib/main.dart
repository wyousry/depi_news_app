import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/data/repositories/news_repository.dart';
import 'package:depi_news_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translation', 
      fallbackLocale: const Locale('en'),
      child: RepositoryProvider(
        create: (_) => NewsRepository(),
        child: const MyApp(),
      ),
    ),
  );
}
