import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/top_Apple_headlines_bloc.dart';
import '../bloc/tesla_bloc.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Apple Headlines'),
              Tab(text: 'Tesla Headlines'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TopHeadlinesTab(),
            _TeslaTab(),
          ],
        ),
      ),
    );
  }
}

class _TopHeadlinesTab extends StatelessWidget {
  const _TopHeadlinesTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopAppleHeadlinesBloc, TopAppleHeadlinesState>(
      builder: (context, state) {
        if (state is TopAppleHeadlinesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TopAppleHeadlinesLoaded) {
          if (state.articles.isEmpty) {
            return const Center(child: Text('No articles.'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TopAppleHeadlinesBloc>().add(FetchTopAppleHeadlinesEvent());
            },
            child: ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (_, i) {
                final a = state.articles[i];
                return _ArticleTile(
                  title: a.title,
                  subtitle: a.description,
                  imageUrl: a.urlToImage,
                  source: a.sourceName,
                  publishedAt: a.publishedAt,
                  url: a.url,
                );
              },
            ),
          );
        } else if (state is TopAppleHeadlinesError) {
          return _ErrorRetry(
            message: state.message,
            onRetry: () => context.read<TopAppleHeadlinesBloc>().add(FetchTopAppleHeadlinesEvent()),
          );
        }
        // initial
        context.read<TopAppleHeadlinesBloc>().add(FetchTopAppleHeadlinesEvent());
        return const SizedBox.shrink();
      },
    );
  }
}

class _TeslaTab extends StatelessWidget {
  const _TeslaTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeslaBloc, TeslaState>(
      builder: (context, state) {
        if (state is TeslaLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TeslaLoaded) {
          if (state.articles.isEmpty) {
            return const Center(child: Text('No articles.'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TeslaBloc>().add(FetchTeslaEvent());
            },
            child: ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (_, i) {
                final a = state.articles[i];
                return _ArticleTile(
                  title: a.title,
                  subtitle: a.description,
                  imageUrl: a.urlToImage,
                  source: a.sourceName,
                  publishedAt: a.publishedAt,
                  url: a.url,
                );
              },
            ),
          );
        } else if (state is TeslaError) {
          return _ErrorRetry(
            message: state.message,
            onRetry: () => context.read<TeslaBloc>().add(FetchTeslaEvent()),
          );
        }
        // initial
        context.read<TeslaBloc>().add(FetchTeslaEvent());
        return const SizedBox.shrink();
      },
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String source;
  final DateTime? publishedAt;
  final String url;

  const _ArticleTile({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imageUrl.isNotEmpty
          ? Image.network(imageUrl, width: 56, height: 56, fit: BoxFit.cover)
          : const SizedBox(width: 56, height: 56),
      title: Text(title),
      subtitle: Text(
        subtitle.isEmpty ? source : subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        publishedAt != null ? _timeAgo(publishedAt!) : '',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () async {

      },
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
    }
}

class _ErrorRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorRetry({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
      ]),
    );
  }
}
