import '../../domain/entities/grammatical_form.dart';

class GrammaticalFormModel extends GrammaticalForm {
  GrammaticalFormModel({
    required int id,
    required int wordID,
    required String partOfSpeech,
  }) : super(partOfSpeech: partOfSpeech);

  factory GrammaticalFormModel.fromJson(Map<String, dynamic> parsedJson) {
    return GrammaticalFormModel(
      id: parsedJson['id'],
      wordID: parsedJson['english_word_id'],
      partOfSpeech: parsedJson['part_of_speech'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"part_of_speech": partOfSpeech};
  }
}
