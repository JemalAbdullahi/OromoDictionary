import 'package:oromo_dictionary/models/phrase.dart';
import 'package:oromo_dictionary/viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class PhraseViewModel {
  late final Phrase _phrase;

  PhraseViewModel(this._phrase);

  int get id {
    return this._phrase.id;
  }

  String get phrase {
    return this._phrase.phrase;
  }
  
  String get example {
    return this._phrase.example;
  }

  int get formID {
    return this._phrase.formID;
  }

  List<OromoTranslationViewModel> get translations {
    return this._phrase.translations;
  }

  String translationToString() {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.writeAll(translations, ", ");
    return stringBuffer.toString();
  }

  String exampleToString() {
    if (example.isEmpty) return example;
    return phrase.isEmpty ? example : "($example)";
  }
}