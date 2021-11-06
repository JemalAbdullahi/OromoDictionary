import '../bloc_imports.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/search_page/get_english_word_list.dart' as english;
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/search_page/get_oromo_word_list.dart' as oromo;

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc
    extends Bloc<SearchPageEvent, PageState> {
  english.GetEnglishWordList getEnglishWordList;
  oromo.GetOromoWordList getOromoWordList;
  InputValidator inputValidator;
  bool isEnglish = true;

  SearchPageBloc({
    required this.getEnglishWordList,
    required this.getOromoWordList,
    required this.inputValidator,
  }) : super(Empty()) {
    on<GetListForEnglishWord>(_onGetListForEnglishWord);
    on<GetListForOromoWord>(_onGetListForOromoWord);
    on<ChangeLanguageSelected>(_onChangeLanguageSelected);
  }

  _onGetListForEnglishWord(
      GetListForEnglishWord event, Emitter<PageState> emit) {
    ///Validate the input
    final inputEither = inputValidator.isValid(event.englishTerm);

    ///If the input is invalid, emit an Error state, else emit a Loading state,
    ///then retrieve the appropriate word list,
    ///if, there is an error retrieving the list, then emit an Error state,
    ///else emit a Loaded state
    return inputEither.fold(
      (failure) => emit(new Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
      (bool) async {
        emit(Loading());
        await getEnglishWordList(english.Params(englishTerm: event.englishTerm))
            .then(
          (failureOrWordList) => emit(
            failureOrWordList.fold(
              (failure) => new Error(message: mapFailureToMessage(failure)),
              (wordList) => new Loaded(wordList: wordList),
            ),
          ),
        );
      },
    );
  }

  _onGetListForOromoWord(
      GetListForOromoWord event, Emitter<PageState> emit) {
    ///Validate the input
    final inputEither = inputValidator.isValid(event.oromoTerm);

    ///If the input is invalid, emit an Error state, else emit a Loading state,
    ///then retrieve the appropriate word list,
    ///if, there is an error retrieving the list, then emit an Error state,
    ///else emit a Loaded state
    return inputEither
        .fold((failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
            (bool) async {
      emit(new Loading());
      final failureOrWordList =
          await getOromoWordList(oromo.Params(oromoTerm: event.oromoTerm));

      failureOrWordList.fold(
        (failure) => emit(new Error(message: mapFailureToMessage(failure))),
        (wordList) => emit(new Loaded(wordList: wordList)),
      );
    });
  }

  _onChangeLanguageSelected(
      ChangeLanguageSelected event, Emitter<PageState> emit) {
    isEnglish = event.isEnglish;
    return emit(Empty());
  }

/* Deprecated
  @override
  Stream<EnglishOromoDictionaryState> mapEventToState(
    EnglishOromoDictionaryEvent event,
  ) async* {
    // Immediately branching the logic with type checking,
    // for the event to be smart casted
    if (event is GetListForEnglishWord) {
      yield* _eitherInputValidatedOrErrorState(event, event.englishTerm);
    } else if (event is GetListForOromoWord) {
      yield* _eitherInputValidatedOrErrorState(event, event.oromoTerm);
    } else if (event is GetEnglishTranslationsForOromoWord) {
      yield* _eitherInputValidatedOrErrorState(event, event.oromoWord);
    } else if (event is ChangeLanguageSelected) {
      isEnglish = event.isEnglish;
      yield Empty();
    }
  }
 
  Stream<EnglishOromoDictionaryState> _eitherInputValidatedOrErrorState(
      EnglishOromoDictionaryEvent event, String searchTerm) async* {
    final inputEither = inputValidator.isValid(searchTerm);
    yield* inputEither.fold((failure) async* {
      yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
    }, (bool) async* {
      yield Loading();
      final failureOrWordList;
      switch (event.runtimeType) {
        case GetListForEnglishWord:
          failureOrWordList =
              await getEnglishWordList(english.Params(englishTerm: searchTerm));
          break;
        case GetListForOromoWord:
          failureOrWordList =
              await getOromoWordList(oromo.Params(oromoTerm: searchTerm));
          break;
        case GetEnglishTranslationsForOromoWord:
          failureOrWordList =
              await getEnglishTranslations(Params(oromoWord: searchTerm));
          break;
        default:
          failureOrWordList = Left(ServerFailure());
      }
      yield* _eitherLoadedOrErrorState(failureOrWordList);
    });
  }

  Stream<EnglishOromoDictionaryState> _eitherLoadedOrErrorState(
      Either<Failure, dynamic> failureOrWordList) async* {
    yield failureOrWordList.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (wordList) => Loaded(wordList: wordList),
    );
  }
  */
}
