import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/core/error/failures.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/oromo_word_page/get_english_translations.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/bloc_imports.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/oromo_translation_page_bloc/oromo_translation_page_bloc.dart';
import 'oromo_translation_page_bloc_test.mocks.dart';

@GenerateMocks([GetEnglishTranslations, InputValidator])
void main() {
  late OromoTranslationPageBloc bloc;
  late MockGetEnglishTranslations mockGetEnglishTranslations;
  late MockInputValidator mockInputValidator;

  setUp(() {
    mockGetEnglishTranslations = MockGetEnglishTranslations();
    mockInputValidator = MockInputValidator();
    bloc = OromoTranslationPageBloc(
        getEnglishTranslations: mockGetEnglishTranslations,
        inputValidator: mockInputValidator);
  });

  test(
    'initialState should be Empty',
    () async {
      //assert
      expect(bloc.state, equals(Empty()));
    },
  );
   group('GetEnglishTranslationsList', () {
    final searchWord = 'daabaluu';
    final tWord = 'accumulate';
    final tPhonetic = 'akkumuuleet';
    final tEnglishWord = EnglishWord(id: 160, word: tWord, phonetic: tPhonetic);
    final List<EnglishWord> tEnglishWordList = [tEnglishWord];

    void setUpMockInputValidatorSuccess() =>
        when(mockInputValidator.isValid(any)).thenReturn(Right(true));

    test(
      'should call the InputValidator to validate the input string',
      () async {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishTranslations(any))
            .thenAnswer((_) async => Right(tEnglishWordList));
        //act
        bloc.add(GetEnglishTranslationsList(searchWord));
        await untilCalled(mockInputValidator.isValid(any));
        //assert
        verify(mockInputValidator.isValid(searchWord));
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
        bloc.add(GetEnglishTranslationsList(searchWord));
      },
    );

    test(
      'should get data from the english use case',
      () async {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishTranslations(any))
            .thenAnswer((_) async => Right(tEnglishWordList));
        //act
        bloc.add(GetEnglishTranslationsList(searchWord));
        await untilCalled(mockGetEnglishTranslations(any));
        //assert
        verify(mockGetEnglishTranslations(Params(oromoWord: searchWord)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is retrieved successfully',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishTranslations(any))
            .thenAnswer((_) async => Right(tEnglishWordList));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(wordList: tEnglishWordList),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.add(GetEnglishTranslationsList(searchWord));
      },
    );
    test(
      'should emit [Loading, Error] when data retrieval fails',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishTranslations(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.add(GetEnglishTranslationsList(searchWord));
      },
    );
    test(
      'should emit [Loading, Error] with a proper message for when data retrieval fails',
      () async* {
        //arrange
        setUpMockInputValidatorSuccess();
        when(mockGetEnglishTranslations(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        //act
        bloc.add(GetEnglishTranslationsList(searchWord));
      },
    );
  });

}
