import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/phrase.dart';

class PhraseModel extends Phrase {
  PhraseModel({
    required int id,
    required int formID,
    required String phrase,
    required String example,
  }) : super(phrase: phrase, example: example);

  factory PhraseModel.fromJson(Map<String, dynamic> parsedJson) {
    return PhraseModel(
      id: parsedJson['id'],
      formID: parsedJson['grammatical_form_id'],
      phrase: parsedJson['phrase'],
      example: parsedJson['example'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"phrase": phrase, "example": example};
  }
}
