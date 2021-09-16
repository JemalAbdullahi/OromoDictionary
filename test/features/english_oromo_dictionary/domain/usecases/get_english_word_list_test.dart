import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/get_english_word_list.dart';
import 'get_english_word_list_test.mocks.dart';

class MockEnglishOromoDictionaryRepository extends Mock
    implements EnglishOromoDictionaryRepository {}

@GenerateMocks([MockEnglishOromoDictionaryRepository])
void main() {
  late GetEnglishWordList usecase;
  late MockMockEnglishOromoDictionaryRepository
      mockEnglishOromoDictionaryRepository;
  late final tEnglishWordList, tEnglishTerm;
  setUp(() {
    mockEnglishOromoDictionaryRepository =
        MockMockEnglishOromoDictionaryRepository();
    usecase = GetEnglishWordList(mockEnglishOromoDictionaryRepository);
  });

  tEnglishTerm = "aba";
  tEnglishWordList = [
    EnglishWord(id: 0, word: "aback", phonetic: "abaak"),
    EnglishWord(id: 1, word: "abacus", phonetic: "abaakas"),
    EnglishWord(id: 2, word: "abaft", phonetic: "abaaft"),
  ];
  test(
    'should get a list of english words/translations for the oromo term from the repository',
    () async {
      //arrange
      when(mockEnglishOromoDictionaryRepository.getEnglishWordList(any))
          .thenAnswer((_) async => Right(tEnglishWordList));
      //act
      final result = await usecase(Params(englishTerm: tEnglishTerm));
      //assert
      expect(result, Right(tEnglishWordList));
      verify(mockEnglishOromoDictionaryRepository
          .getEnglishWordList(tEnglishTerm));
      verifyNoMoreInteractions(mockEnglishOromoDictionaryRepository);
    },
  );
}
