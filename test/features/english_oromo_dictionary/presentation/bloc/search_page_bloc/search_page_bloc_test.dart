import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/core/error/failures.dart';
import 'package:oromo_dictionary/core/presentation/util/input_validator.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/oromo_translation_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/search_page/get_english_word_list.dart'
    as english;
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/search_page/get_oromo_word_list.dart'
    as oromo;
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/bloc_imports.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/search_page_bloc/search_page_bloc.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/page_states.dart';
import 'search_page_bloc_test.mocks.dart';

@GenerateMocks([
  english.GetEnglishWordList,
  oromo.GetOromoWordList,
  InputValidator
])
void main() {
  late SearchPageBloc bloc;
  late MockGetEnglishWordList mockGetEnglishWordList;
  late MockGetOromoWordList mockGetOromoWordList;
  late MockInputValidator mockInputValidator;

  setUp(() {
    mockGetEnglishWordList = MockGetEnglishWordList();
    mockGetOromoWordList = MockGetOromoWordList();
    mockInputValidator = MockInputValidator();
    bloc = SearchPageBloc(
        getEnglishWordList: mockGetEnglishWordList,
        getOromoWordList: mockGetOromoWordList,
        inputValidator: mockInputValidator);
  });

  test(
    'initialState should be Empty',
    () async {
      //assert
      expect(bloc.state, equals(Empty()));
    },
  );

  group('GetListForEnglishWord', () {
    final tWord = 'aback';
    final tPhonetic = 'abaak';
    final tEnglishWord = EnglishWord(word: tWord, phonetic: tPhonetic);
    final List<EnglishWord> tEnglishWordList = [tEnglishWord];

    void setUpMockInputValidatorSuccess() =>
        when(mockInputValidator.isValid(any)).thenReturn(Right(true));

    test(
      'should call the InputValidator to validate the input string',
      () async {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishWordList(any))
            .thenAnswer((_) async => Right(tEnglishWordList));
        //act
        bloc.isEnglish = true;
        bloc.add(GetListForEnglishWord(tWord));
        await untilCalled(mockInputValidator.isValid(any));
        //assert
        verify(mockInputValidator.isValid(tWord));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async* {
        //arrange
        when(mockInputValidator.isValid(any))
            .thenReturn(Left(InvalidInputFailure()));
        //assert later
        final expected = [
          //The initial state is always emitted first
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.add(GetListForEnglishWord(tWord));
      },
    );

    test(
      'should get data from the english use case',
      () async {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishWordList(any))
            .thenAnswer((_) async => Right(tEnglishWordList));
        //act
        bloc.isEnglish = true;
        bloc.add(GetListForEnglishWord(tWord));
        await untilCalled(mockGetEnglishWordList(any));
        //assert
        verify(mockGetEnglishWordList(english.Params(englishTerm: tWord)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is retrieved successfully',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishWordList(any))
            .thenAnswer((_) async => Right(tEnglishWordList));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(wordList: tEnglishWordList),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.isEnglish = true;
        bloc.add(GetListForEnglishWord(tWord));
      },
    );
    test(
      'should emit [Loading, Error] when data retrieval fails',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishWordList(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.isEnglish = true;
        bloc.add(GetListForEnglishWord(tWord));
      },
    );
    test(
      'should emit [Loading, Error] with a proper message for when data retrieval fails',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishWordList(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.isEnglish = true;
        bloc.add(GetListForEnglishWord(tWord));
      },
    );
  });
  group('GetListForOromoWord', () {
    final tID = 62;
    final tTranslation = 'gabaabaa';
    final tPhraseID = 17;
    final tOromoTranslationModel = OromoTranslationModel(
        id: tID, phraseID: tPhraseID, translation: tTranslation);
    final OromoTranslation tOromoTranslation = tOromoTranslationModel;
    final List<OromoTranslation> tOromoWordList = [tOromoTranslation];

    void setUpMockInputValidatorSuccess() =>
        when(mockInputValidator.isValid(any)).thenReturn(Right(true));

    test(
      'should call the InputValidator to validate the input string',
      () async {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetOromoWordList(any))
            .thenAnswer((_) async => Right(tOromoWordList));
        //act
        bloc.isEnglish = false;
        bloc.add(GetListForOromoWord(tTranslation));
        await untilCalled(mockInputValidator.isValid(any));
        //assert
        verify(mockInputValidator.isValid(tTranslation));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async* {
        //arrange
        when(mockInputValidator.isValid(any))
            .thenReturn(Left(InvalidInputFailure()));
        //assert later
        final expected = [
          //The initial state is always emitted first
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.isEnglish = false;
        bloc.add(GetListForOromoWord(tTranslation));
      },
    );

    test(
      'should get data from the oromo use case',
      () async {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetOromoWordList(any))
            .thenAnswer((_) async => Right(tOromoWordList));
        //act
        bloc.isEnglish = false;
        bloc.add(GetListForOromoWord(tTranslation));
        await untilCalled(mockGetOromoWordList(any));
        //assert
        verify(mockGetOromoWordList(oromo.Params(oromoTerm: tTranslation)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is retrieved successfully',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetOromoWordList(any))
            .thenAnswer((_) async => Right(tOromoWordList));
        //act
        final expected = [
          Empty(),
          Loading(),
          Loaded(wordList: tOromoWordList),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //assert
        bloc.isEnglish = false;
        bloc.add(GetListForOromoWord(tTranslation));
      },
    );
    test(
      'should emit [Loading, Error] when data retrieval fails',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetOromoWordList(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //act
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //assert
        bloc.isEnglish = false;
        bloc.add(GetListForOromoWord(tTranslation));
      },
    );
    test(
      'should emit [Loading, Error] with a proper message for when data retrieval fails',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetOromoWordList(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //act
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //assert
        bloc.isEnglish = false;
        bloc.add(GetListForOromoWord(tTranslation));
      },
    );
  });

  group("ChangeLanguageSelected", () {
    test(
      'should emit [Empty] when the Language is changed to English',
      () async {
        //arrange
        //act
        expectLater(bloc.state, equals(Empty()));
        //assert
        bloc.add(ChangeLanguageSelected(isEnglish: true));
        expect(bloc.isEnglish, true);
      },
    );
    test(
      'should emit [Empty] when the Language is changed to Oromo',
      () async {
        //arrange
        //act
        expectLater(bloc.state, equals(Empty()));
        //assert
        bloc.add(ChangeLanguageSelected(isEnglish: false));
      },
    );
  });
  
}
