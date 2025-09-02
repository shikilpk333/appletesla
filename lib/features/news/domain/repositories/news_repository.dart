import '../entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopAppleHeadlines();
  Future<List<Article>> getTeslaHeadlines();
}
