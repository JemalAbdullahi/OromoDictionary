import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/grammatical_form_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/grammatical_form.dart';

void main() {
  final tGrammaticalFormModel =
      GrammaticalFormModel(id: 0, wordID: 0, partOfSpeech:'noun');

  test(
    'should be a subclass of GrammaticalForm entity',
    () async {
      //assert
      expect(tGrammaticalFormModel, isA<GrammaticalForm>());
    },
  );
}
