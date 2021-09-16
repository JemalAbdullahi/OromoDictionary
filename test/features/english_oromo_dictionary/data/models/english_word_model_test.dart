import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_word_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';

void main() {
  final tEnglishWordModel =
      EnglishWordModel(id: 0, word: "aback", phonetic: "abaak");

  test(
    'should be a subclass of EnglishWord entity',
    () async {
      //assert
      expect(tEnglishWordModel, isA<EnglishWord>());
    },
  );
}
