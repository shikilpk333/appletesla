import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopAppleHeadlines();
  Future<List<ArticleModel>> getTeslaHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  final String apiKey;
  NewsRemoteDataSourceImpl({required this.client, required this.apiKey});

  @override
  Future<List<ArticleModel>> getTopAppleHeadlines() async {
    final uri = Uri.parse(
      'https://newsapi.org/v2/everything?q=apple&from=2025-09-01&to=2025-09-01&sortBy=popularity&apiKey=$apiKey',
    );
    final response = await client.get(uri);
    return _parseArticles(response, onError: "Failed to load Top Headlines India");
  }

  @override
  Future<List<ArticleModel>> getTeslaHeadlines() async {
    final uri = Uri.parse(
      'https://newsapi.org/v2/everything?q=tesla&from=2025-08-02&sortBy=publishedAt&apiKey=$apiKey',
    );
    final response = await client.get(uri);
    return _parseArticles(response, onError: "Failed to load Bitcoin Articles");
  }

  List<ArticleModel> _parseArticles(http.Response response, {required String onError}) {
    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      final list = (map['articles'] as List<dynamic>? ?? [])
          .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    } else {
      throw ServerException("$onError (code: ${response.statusCode})");
    }
  }
}
