import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/search_page/get_english_word_list.dart';
import 'get_english_word_list_test.mocks.dart';


@GenerateMocks([EnglishOromoDictionaryRepository])
void main() {
  late GetEnglishWordList usecase;
  late MockEnglishOromoDictionaryRepository
      mockEnglishOromoDictionaryRepository;
  late final tEnglishWordList, tEnglishTerm;
  setUp(() {
    mockEnglishOromoDictionaryRepository =
        MockEnglishOromoDictionaryRepository();
    usecase = GetEnglishWordList(mockEnglishOromoDictionaryRepository);
  });

  tEnglishTerm = "aba";
  tEnglishWordList = [
    EnglishWord(id: 1,word: "aback", phonetic: "abaak"),
    EnglishWord(id: 2,word: "abacus", phonetic: "abaakas"),
    EnglishWord(id: 3,word: "abaft", phonetic: "abaaft"),
  ];
  test(
    'should get a list of english words for the english term from the repository',
    () async {
      //arrange
      when(mockEnglishOromoDictionaryRepository.getWordList(desiredList: anyNamed("desiredList"), searchTerm: anyNamed("searchTerm")))
          .thenAnswer((_) async => Right(tEnglishWordList));
      //act
      final result = await usecase(Params(englishTerm: tEnglishTerm));
      //assert
      expect(result, Right(tEnglishWordList));
      verify(mockEnglishOromoDictionaryRepository
          .getWordList(desiredList: "EnglishWordList", searchTerm: tEnglishTerm));
      verifyNoMoreInteractions(mockEnglishOromoDictionaryRepository);
    },
  );
}
