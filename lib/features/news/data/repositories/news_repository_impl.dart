import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remote;

  NewsRepositoryImpl(this.remote);

  @override
  Future<List<Article>> getTopAppleHeadlines() => remote.getTopAppleHeadlines();

  @override
  Future<List<Article>> getTeslaHeadlines() => remote.getTeslaHeadlines();
}
