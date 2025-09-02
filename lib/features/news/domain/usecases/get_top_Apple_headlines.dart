import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetAppleHeadlines {
  final NewsRepository repository;
  GetAppleHeadlines(this.repository);
  Future<List<Article>> call() => repository.getTopAppleHeadlines();
}
