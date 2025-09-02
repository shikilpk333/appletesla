import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_tesla_articles.dart';

part 'tesla_event.dart';
part 'tesla_state.dart';

class TeslaBloc extends Bloc<TeslaEvent, TeslaState> {
  final GetTeslaHeadline getTeslaArticles;

  TeslaBloc(this.getTeslaArticles) : super(TeslaInitial()) {
    on<FetchTeslaEvent>((event, emit) async {
      emit(TeslaLoading());
      try {
        final articles = await getTeslaArticles();
        emit(TeslaLoaded(articles));
      } catch (e) {
        emit(TeslaError(e.toString()));
      }
    });
  }
}
