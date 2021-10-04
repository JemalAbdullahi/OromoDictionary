import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/oromo_word_page/get_english_translations.dart';
import 'get_english_translations_test.mocks.dart';

@GenerateMocks([EnglishOromoDictionaryRepository])
void main() {
  late GetEnglishTranslations usecase;
  late MockEnglishOromoDictionaryRepository
      mockEnglishOromoDictionaryRepository;
  late final tEnglishWordList, tOromoWord;
  setUp(() {
    mockEnglishOromoDictionaryRepository =
        MockEnglishOromoDictionaryRepository();
    usecase = GetEnglishTranslations(mockEnglishOromoDictionaryRepository);
  });

  tOromoWord = "daabaluu";
  tEnglishWordList = [
    EnglishWord(word: "accumulate", phonetic: "akkumuuleet"),
  ];
  test(
    'should get a list of english translations for the oromo word from the repository',
    () async {
      //arrange
      when(mockEnglishOromoDictionaryRepository.getWordList(
              desiredList: anyNamed("desiredList"),
              searchTerm: anyNamed("searchTerm")))
          .thenAnswer((_) async => Right(tEnglishWordList));
      //act
      final result = await usecase(Params(oromoWord: tOromoWord));
      //assert
      expect(result, Right(tEnglishWordList));
      verify(mockEnglishOromoDictionaryRepository.getWordList(
          desiredList: "EnglishTranslations", searchTerm: tOromoWord));
      verifyNoMoreInteractions(mockEnglishOromoDictionaryRepository);
    },
  );
}
