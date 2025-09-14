import 'package:depi_news_app/core/app_color.dart';
import 'package:flutter/material.dart';
import '../data/models/news_model.dart';

class NewsItem extends StatelessWidget {
  final NewsModel news;
  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.assetsColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColor.assetsColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: news.imageUrl.isNotEmpty
                  ? Image.network(
                      news.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.image,
                        size: 30,
                        color: AppColor.assetsColor,
                      ),
                    )
                  : Icon(
                      Icons.image,
                      size: 30,
                      color: AppColor.assetsColor,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryColor,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Category and Time
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(news.category),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        news.category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.backgroundColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      news.timeAgo,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.assetsColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'technology':
        return  AppColor.techColor; 
      case 'politics':
        return AppColor.politicsColor; 
      case 'sports':
        return AppColor.sportsColor;
      case 'science':
        return  AppColor.scienceColor;
      case 'business':
        return AppColor.businessColor;
      case 'health':
        return AppColor.healthColor;
      default:
        return AppColor.assetsColor;
    }
  }
}