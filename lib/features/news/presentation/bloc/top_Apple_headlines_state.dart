part of 'top_Apple_headlines_bloc.dart';

abstract class TopAppleHeadlinesState {}

class TopAppleHeadlinesInitial extends TopAppleHeadlinesState {}

class TopAppleHeadlinesLoading extends TopAppleHeadlinesState {}

class TopAppleHeadlinesLoaded extends TopAppleHeadlinesState {
  final List<Article> articles;
  TopAppleHeadlinesLoaded(this.articles);
}

class TopAppleHeadlinesError extends TopAppleHeadlinesState {
  final String message;
  TopAppleHeadlinesError(this.message);
}
