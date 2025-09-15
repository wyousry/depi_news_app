import 'package:depi_news_app/core/app_color.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/cubit/news_cubit.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/cubit/news_state.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/widget/news_item.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/widget/search_bar.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/cubit/search_cubit.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/cubit/search_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FinalSearchBar(controller: _searchController),

        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, searchState) {
              if (searchState is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (searchState is SearchLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: searchState.news.length,
                  itemBuilder: (context, index) {
                    return NewsItem(news: searchState.news[index]);
                  },
                );
              } else if (searchState is SearchError) {
                return Center(
                  child: Text("${"error".tr()}: ${searchState.message}"),
                );
              }
              return BlocBuilder<NewsCubit, NewsState>(
                builder: (context, newsState) {
                  if (newsState is NewsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColor.secondaryColor),
                      ),
                    );
                  } else if (newsState is NewsLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: newsState.articles.length,
                      itemBuilder: (context, index) {
                        return NewsItem(news: newsState.articles[index]);
                      },
                    );
                  } else if (newsState is NewsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: AppColor.assetsColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            " It seems there is a problem with the server".tr(),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.assetsColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            newsState.message,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.assetsColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<NewsCubit>().loadNews();
                            },
                            child: const Text("try_again").tr(),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}


