import 'package:bloc/bloc.dart';
import '../../../domain/entities/english_word.dart';
import '../../../domain/usecases/english_word_page/get_english_definition.dart';

import '../bloc_imports.dart';
import '../page_states.dart';
part 'english_translation_page_event.dart';
part 'english_translation_page_state.dart';

class EnglishTranslationPageBloc
    extends Bloc<EnglishTranslationPageEvent, PageState> {
  GetEnglishWord getEnglishDefinition;

  EnglishTranslationPageBloc({required this.getEnglishDefinition})
      : super(Empty()) {
    on<GetEnglishWordInfo>(_onGetEnglishWordInfo);
    on<DisposeEnglishPage>(_onDisposeEnglishPage);
  }

  _onGetEnglishWordInfo(
      GetEnglishWordInfo event, Emitter<PageState> emit) async {
    emit(Empty());
    emit(Loading());
    final failureOrEnglishWord =
        await getEnglishDefinition(Params(englishWord: event.englishWord));
    emit(failureOrEnglishWord.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (englishWord) => Loaded(englishWord: englishWord)));
  }

  _onDisposeEnglishPage(
      DisposeEnglishPage event, Emitter<PageState> emit) async {
    emit(Empty());
  }
}
