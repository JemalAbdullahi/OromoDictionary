import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/get_oromo_word_list.dart';
import 'get_oromo_word_list_test.mocks.dart';


@GenerateMocks([EnglishOromoDictionaryRepository])
void main() {
  late GetOromoWordList usecase;
  late MockEnglishOromoDictionaryRepository
      mockEnglishOromoDictionaryRepository;
  late final tOromoTranslationList, tOromoTerm;
  setUp(() {
    mockEnglishOromoDictionaryRepository =
        MockEnglishOromoDictionaryRepository();
    usecase = GetOromoWordList(mockEnglishOromoDictionaryRepository);
  });

  tOromoTerm = "gab";
  tOromoTranslationList = [
    OromoTranslation(translation: "gabaabaa"),
    OromoTranslation(translation: "gabaabina"),
    OromoTranslation(translation: "gabaabsuu"),
  ];
  test(
    'should get a list of oromo words for the oromo term from the repository',
    () async {
      //arrange
      when(mockEnglishOromoDictionaryRepository.getWordList(
              isEnglish: anyNamed("isEnglish"),
              searchTerm: anyNamed("searchTerm")))
          .thenAnswer((_) async => Right(tOromoTranslationList));
      //act
      final result = await usecase(Params(oromoTerm: tOromoTerm));
      //assert
      expect(result, Right(tOromoTranslationList));
      verify(mockEnglishOromoDictionaryRepository.getWordList(
          isEnglish: false, searchTerm: tOromoTerm));
      verifyNoMoreInteractions(mockEnglishOromoDictionaryRepository);
    },
  );
}
