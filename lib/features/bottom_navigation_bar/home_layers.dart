import 'package:depi_news_app/core/app_color.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/cubit/news_cubit.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/data/repositories/news_repository.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/home_screen.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/saved/saved_screen.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/cubit/search_cubit.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';


class HomeLayers extends StatefulWidget {
  const HomeLayers({super.key});

  @override
  State<HomeLayers> createState() => _HomeLayersState();
}

class _HomeLayersState extends State<HomeLayers> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      HomeScreen(),
      SearchScreen(),
      SavedScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => NewsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                NewsCubit(context.read<NewsRepository>())..loadNews(),
          ),
          BlocProvider(
            create: (context) =>
                SearchCubit(context.read<NewsRepository>()),
          ),
        ],
        child: Material(
          child: Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              title: Text(
                _currentIndex == 0
                    ? "News"
                    : _currentIndex == 1
                        ? "Search"
                        : "Saved",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColor.backgroundColor,
              elevation: 0,
              actions: _currentIndex == 0
                  ? [
                      IconButton(
                        onPressed: () {
          
                        },
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: AppColor.primaryColor,
                          size: 24,
                        ),
                      ),
                    ]
                  : null,
            ),
            body: _pages[_currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: AppColor.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.assetsColor.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                selectedItemColor: AppColor.secondaryColor,
                unselectedItemColor: AppColor.assetsColor,
                backgroundColor: AppColor.backgroundColor,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined),
                    activeIcon: Icon(Icons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmarks_outlined),
                    activeIcon: Icon(Icons.bookmarks),
                    label: "Saved",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}