import 'package:oromo_dictionary/viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class Phrase {
  late final int id;
  late final int formID;
  late final String phrase;
  late final String example;
  late final List<OromoTranslationViewModel> translations;

  Phrase(this.id, this.formID, this.phrase, this.example);

  factory Phrase.fromJson(Map<String, dynamic> parsedJson) {
    return Phrase(
      parsedJson['id'],
      parsedJson['grammatical_form_id'],
      parsedJson['phrase'],
      parsedJson['example'],
    );
  }
}
