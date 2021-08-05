
import 'package:oromo_dictionary/viewmodels/phrase_view_models/phrase_view_model.dart';

class GrammaticalForm {
  late final int id;
  late final int wordID;
  late final String partOfSpeech;
  late List<PhraseViewModel> phrases;

  GrammaticalForm(this.id, this.wordID, this.partOfSpeech);

  factory GrammaticalForm.fromJson(Map<String, dynamic> parsedJson) {
    return GrammaticalForm(
      parsedJson['id'],
      parsedJson['english_word_id'],
      parsedJson['part_of_speech'],
    );
  }
}