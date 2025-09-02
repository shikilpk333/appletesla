import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/news/data/datasources/news_remote_data_source.dart';
import 'features/news/data/repositories/news_repository_impl.dart';
import 'features/news/domain/usecases/get_top_Apple_headlines.dart';
import 'features/news/domain/usecases/get_tesla_articles.dart';
import 'features/news/presentation/bloc/top_Apple_headlines_bloc.dart';
import 'features/news/presentation/bloc/tesla_bloc.dart';
import 'features/news/presentation/pages/news_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const apiKey = '99c229fd51a44e18872ff3e2138cca58';

  final client = http.Client();
  final remote = NewsRemoteDataSourceImpl(client: client, apiKey: apiKey);
  final repository = NewsRepositoryImpl(remote);
  final getTopHeadlinesIndia = GetAppleHeadlines(repository);
  final getBitcoinArticles = GetTeslaHeadline(repository);

  runApp(MyApp(
    getTopHeadlinesIndia: getTopHeadlinesIndia,
    getBitcoinArticles: getBitcoinArticles,
  ));
}

class MyApp extends StatelessWidget {
  final GetAppleHeadlines getTopHeadlinesIndia;
  final GetTeslaHeadline getBitcoinArticles;

  const MyApp({
    super.key,
    required this.getTopHeadlinesIndia,
    required this.getBitcoinArticles,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Dispatch initial events immediately
        BlocProvider(create: (_) => TopAppleHeadlinesBloc(getTopHeadlinesIndia)..add(FetchTopAppleHeadlinesEvent())),
        BlocProvider(create: (_) => TeslaBloc(getBitcoinArticles)..add(FetchTeslaEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Tabs',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
          useMaterial3: true,
        ),
        home: const NewsPage(),
      ),
    );
  }
}
