import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/presentation/util/input_validator.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/get_english_word_list.dart'
    as english;
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/get_oromo_word_list.dart'
    as oromo;

part 'english_oromo_dictionary_event.dart';
part 'english_oromo_dictionary_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The search term must not be empty.";

class EnglishOromoDictionaryBloc
    extends Bloc<EnglishOromoDictionaryEvent, EnglishOromoDictionaryState> {
  english.GetEnglishWordList getEnglishWordList;
  oromo.GetOromoWordList getOromoWordList;
  InputValidator inputValidator;

  EnglishOromoDictionaryBloc({
    required this.getEnglishWordList,
    required this.getOromoWordList,
    required this.inputValidator,
  }) : super(Empty());

  @override
  Stream<EnglishOromoDictionaryState> mapEventToState(
    EnglishOromoDictionaryEvent event,
  ) async* {
    // Immediately branching the logic with type checking,
    // for the event to be smart casted
    if (event is GetListForEnglishWord) {
      yield* _eitherInputValidatedOrErrorState(event.englishTerm, true);
    } else if (event is GetListForOromoWord) {
      yield* _eitherInputValidatedOrErrorState(event.oromoTerm, false);
    }
  }

  Stream<EnglishOromoDictionaryState> _eitherInputValidatedOrErrorState(
      String searchTerm, bool isEnglish) async* {
    final inputEither = inputValidator.isValid(searchTerm);
    yield* inputEither.fold((failure) async* {
      yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
    }, (bool) async* {
      yield Loading();
      final failureOrWordList = isEnglish
          ? await getEnglishWordList(english.Params(englishTerm: searchTerm))
          : await getOromoWordList(oromo.Params(oromoTerm: searchTerm));
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

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
