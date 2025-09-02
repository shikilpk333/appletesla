part of 'tesla_bloc.dart';

abstract class TeslaState {}

class TeslaInitial extends TeslaState {}

class TeslaLoading extends TeslaState {}

class TeslaLoaded extends TeslaState {
  final List<Article> articles;
  TeslaLoaded(this.articles);
}

class TeslaError extends TeslaState {
  final String message;
  TeslaError(this.message);
}
