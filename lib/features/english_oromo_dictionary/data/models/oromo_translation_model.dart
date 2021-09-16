import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/oromo_translation.dart';

class OromoTranslationModel extends OromoTranslation {
  OromoTranslationModel({
    required int id,
    required int phraseID,
    required String translation,
  }) : super(translation: translation);

  factory OromoTranslationModel.fromJson(Map<String, dynamic> parsedJson) {
    return OromoTranslationModel(
      id: parsedJson['id'],
      phraseID: parsedJson['phrase_id'],
      translation: parsedJson['translation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"translation": translation};
  }
}
