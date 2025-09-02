import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTeslaHeadline {
  final NewsRepository repository;
  GetTeslaHeadline(this.repository);
  Future<List<Article>> call() => repository.getTeslaHeadlines();
}
