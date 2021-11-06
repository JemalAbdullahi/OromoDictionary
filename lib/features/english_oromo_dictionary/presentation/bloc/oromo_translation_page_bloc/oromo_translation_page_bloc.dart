import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/oromo_word_page/get_english_translations.dart';
import '../bloc_imports.dart';

part 'oromo_translation_page_event.dart';
part 'oromo_translation_page_state.dart';

class OromoTranslationPageBloc
    extends Bloc<OromoTranslationPageEvent, PageState> {
  GetEnglishTranslations getEnglishTranslations;
  InputValidator inputValidator;

  OromoTranslationPageBloc({
    required this.getEnglishTranslations,
    required this.inputValidator,
  }) : super(Empty()) {
    on<GetEnglishTranslationsList>(_onGetEnglishTranslationsList);
  }

  _onGetEnglishTranslationsList(
      GetEnglishTranslationsList event, Emitter<PageState> emit) {
    emit(Empty());

    ///Validate the input
    final inputEither = inputValidator.isValid(event.oromoWord);

    ///If the input is invalid, emit an Error state, else emit a Loading state,
    ///then retrieve the appropriate word list,
    ///if, there is an error retrieving the list, then emit an Error state,
    ///else emit a Loaded state
    return inputEither
        .fold((failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
            (bool) async {
      emit(Loading());
      print("Loading");
      final failureOrWordList =
          await getEnglishTranslations(Params(oromoWord: event.oromoWord));

      print("Loaded");
      failureOrWordList.fold(
        (failure) => emit(Error(message: mapFailureToMessage(failure))),
        (wordList) => emit(Loaded(wordList: wordList as List<EnglishWord>)),
      );
    });
  }
}
