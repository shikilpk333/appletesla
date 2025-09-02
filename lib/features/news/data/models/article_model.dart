import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.sourceName,
    super.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: (json['urlToImage'] ?? '') as String,
      sourceName: (json['source']?['name'] ?? '') as String,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
    );
  }
}
