import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/phrase_model.dart';

void main() {
  final tPhraseModel =
      PhraseModel(id: 0, formID: 0, phrase: "", example: "");

  test(
    'should be a subclass of PhraseModel entity',
    () async {
      //assert
      expect(tPhraseModel, isA<PhraseModel>());
    },
  );
}
