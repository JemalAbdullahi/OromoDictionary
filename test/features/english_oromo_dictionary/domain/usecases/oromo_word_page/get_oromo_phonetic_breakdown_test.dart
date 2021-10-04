import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/usecases/oromo_word_page/get_oromo_phonetic_breakdown.dart';

main() {
  late GetOromoPhoneticBreakdown useCase;

  setUp(() {
    useCase = GetOromoPhoneticBreakdown();
  });

  final tOromoWord = 'akka';
  final tPhoneticBreakdown =
      'a: short ah sound as in again or what, (Longer Sound) kk: unstressed k as in coco, a: short ah sound as in again or what';
  test(
    'should return the phonetic breakdown of the oromo word',
    () async {
      //arrange

      //act
      final result = useCase(oromoWord: tOromoWord);
      //assert
      expect(result, tPhoneticBreakdown);
    },
  );
}
