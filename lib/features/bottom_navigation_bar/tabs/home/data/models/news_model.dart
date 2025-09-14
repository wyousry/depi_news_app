class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String publishedAt;
  final String url;
  final String source;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.publishedAt,
    required this.url,
    required this.source,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["urlToImage"] ?? "",
      category: _extractCategory(json),
      publishedAt: json["publishedAt"] ?? "",
      url: json["url"] ?? "",
      source: (json["source"] != null && json["source"]["name"] != null)
          ? json["source"]["name"]
          : "",
    );
  }

  static String _extractCategory(Map<String, dynamic> json) {
    String title = json["title"] ?? "";
    String description = json["description"] ?? "";
    String content = "$title $description".toLowerCase();
    
    if (content.contains('tech') || content.contains('ai') || content.contains('software') || content.contains('computer')) {
      return 'Technology';
    } else if (content.contains('polit') || content.contains('government') || content.contains('election')) {
      return 'Politics';
    } else if (content.contains('sport') || content.contains('football') || content.contains('soccer') || content.contains('championship')) {
      return 'Sports';
    } else if (content.contains('science') || content.contains('research') || content.contains('study') || content.contains('discovery')) {
      return 'Science';
    } else if (content.contains('business') || content.contains('market') || content.contains('economic') || content.contains('financial')) {
      return 'Business';
    } else if (content.contains('health') || content.contains('medical') || content.contains('hospital')) {
      return 'Health';
    } else {
      return 'General';
    }
  }

  String get timeAgo {
    try {
      DateTime publishedDate = DateTime.parse(publishedAt);
      Duration difference = DateTime.now().difference(publishedDate);
      
      if (difference.inHours < 24) {
        return '${difference.inHours}h';
      } else {
        return '${difference.inDays}d';
      }
    } catch (e) {
      return 'now';
    }
  }
}