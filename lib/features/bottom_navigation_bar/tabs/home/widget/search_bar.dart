import 'package:depi_news_app/core/app_color.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/cubit/search_cubit.dart';
import 'package:depi_news_app/features/bottom_navigation_bar/tabs/search/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const FinalSearchBar({
    super.key,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 48,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColor.accentColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return TextField(
            controller: controller,
            readOnly: readOnly,
            onChanged: (value) {
              context.read<SearchCubit>().searchNews(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: AppColor.assetsColor, fontSize: 16),
              prefixIcon: const Icon(Icons.search, color: AppColor.assetsColor, size: 24),
              suffixIcon: state is! SearchEmpty && controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.dangerous_outlined, color:   AppColor.assetsColor, size: 24),
                      onPressed: () {
                        controller.clear();
                        context.read<SearchCubit>().clearSearch();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          );
        },
      ),
    );
  }
}
