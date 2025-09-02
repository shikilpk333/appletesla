import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_top_Apple_headlines.dart';

part 'top_Apple_headlines_event.dart';
part 'top_Apple_headlines_state.dart';

class TopAppleHeadlinesBloc extends Bloc<TopAppleHeadlinesEvent, TopAppleHeadlinesState> {
  final GetAppleHeadlines getTopAppleHeadlines;

  TopAppleHeadlinesBloc(this.getTopAppleHeadlines) : super(TopAppleHeadlinesInitial()) {
    on<FetchTopAppleHeadlinesEvent>((event, emit) async {
      emit(TopAppleHeadlinesLoading());
      try {
        final articles = await getTopAppleHeadlines();
        emit(TopAppleHeadlinesLoaded(articles));
      } catch (e) {
        emit(TopAppleHeadlinesError(e.toString()));
      }
    });
  }
}
