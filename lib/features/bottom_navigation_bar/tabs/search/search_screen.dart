import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/data/models/news_model.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/widget/news_item.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/home/widget/search_bar.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/cubit/search_cubit.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/cubit/search_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FinalSearchBar(controller: _controller),

        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              final searchCubit = context.read<SearchCubit>();

              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SearchLoaded) {
                if (state.news.isEmpty) {
                  return  Center(child: Text("no_results_found".tr()));
                }
                return ListView.builder(
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    final NewsModel news = state.news[index];
                    return NewsItem(news: news);
                  },
                );
              } else if (state is SearchError) {
                return Center(child: Text(state.message));
              } else {

                final recents = searchCubit.recentSearches;
                if (recents.isEmpty) {
                  return  Center(child: Text("search_for_news_above".tr()));
                }
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                     Text(
                      "recent_searches ".tr(),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...recents.map((query) => ListTile(
                          leading: const Icon(Icons.history),
                          title: Text(query),
                          onTap: () {
                            _controller.text = query;
                            context.read<SearchCubit>().searchNews(query);
                          },
                        )),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
