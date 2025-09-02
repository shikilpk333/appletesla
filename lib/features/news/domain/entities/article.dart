class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String sourceName;
  final DateTime? publishedAt;

  const Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.sourceName,
    this.publishedAt,
  });
}
