import 'package:flutter_test/flutter_test.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/oromo_translation_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';


void main() {
  final tOromoTranslationModel =
      OromoTranslationModel(id: 0, phraseID: 0, translation: "translation");

  test(
    'should be a subclass of OromoTranslation entity',
    () async {
      //assert
      expect(tOromoTranslationModel, isA<OromoTranslation>());
    },
  );
}
