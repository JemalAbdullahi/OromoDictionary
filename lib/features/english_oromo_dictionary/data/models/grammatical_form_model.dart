import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/grammatical_form.dart';

class GrammaticalFormModel extends GrammaticalForm{
  GrammaticalFormModel({
    required int id,
    required int wordID,
    required String partOfSpeech,
  }) : super(id: id, wordID: wordID, partOfSpeech: partOfSpeech);

  factory GrammaticalFormModel.fromJson(Map<String, dynamic> parsedJson) {
    return GrammaticalFormModel(
      id:parsedJson['id'],
      wordID:parsedJson['english_word_id'],
      partOfSpeech:parsedJson['part_of_speech'],
    );
  }
}