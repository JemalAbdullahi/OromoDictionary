import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/repositories/english_oromo_dictionary_repository.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/get_oromo_word_list.dart';
import 'get_oromo_word_list_test.mocks.dart';

class MockEnglishOromoDictionaryRepository extends Mock
    implements EnglishOromoDictionaryRepository {}

@GenerateMocks([MockEnglishOromoDictionaryRepository])
void main() {
  late GetOromoWordList usecase;
  late MockMockEnglishOromoDictionaryRepository
      mockEnglishOromoDictionaryRepository;
  late final tOromoTranslationList, tOromoTerm;
  setUp(() {
    mockEnglishOromoDictionaryRepository =
        MockMockEnglishOromoDictionaryRepository();
    usecase = GetOromoWordList(mockEnglishOromoDictionaryRepository);
  });

  tOromoTerm = "gab";
  tOromoTranslationList = [
    OromoTranslation(translation: "gabaabaa"),
    OromoTranslation(translation: "gabaabina"),
    OromoTranslation(translation: "gabaabsuu"),
  ];
  test(
    'should get a list of oromo words/translations for the oromo term from the repository',
    () async {
      //arrange
      when(mockEnglishOromoDictionaryRepository.getOromoWordList(any))
          .thenAnswer((_) async => Right(tOromoTranslationList));
      //act
      final result = await usecase(Params(oromoTerm: tOromoTerm));
      //assert
      expect(result, Right(tOromoTranslationList));
      verify(mockEnglishOromoDictionaryRepository.getOromoWordList(tOromoTerm));
      verifyNoMoreInteractions(mockEnglishOromoDictionaryRepository);
    },
  );
}
