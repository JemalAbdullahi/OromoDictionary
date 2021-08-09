import 'package:oromo_dictionary/src/models/phrase.dart';
import 'package:oromo_dictionary/src/viewmodels/oromo_translation_view_models/oromo_translation_list_view_model.dart';
import 'package:oromo_dictionary/src/viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class PhraseViewModel {
  late final Phrase _phrase;

  PhraseViewModel(this._phrase);

  int get id {
    return this._phrase.id;
  }

  String? get phrase {
    return this._phrase.phrase;
  }

  String? get example {
    return this._phrase.example;
  }

  int get formID {
    return this._phrase.formID;
  }

  List<OromoTranslationViewModel>? get translations {
    return this._phrase.translations;
  }

  set translations(List<OromoTranslationViewModel>? translations) {
    this._phrase.translations = translations;
  }

  setTranslations() async {
    if (translations == null) {
      final translation =
          await OromoTranslationListViewModel.fetchOromoTranslations(id);
      translations = translation;
    }
  }

  String translationToString() {
    List<String> oromoWords = [];
    for (OromoTranslationViewModel oromoWord in translations!) {
      oromoWords.add(oromoWord.translation);
    }

    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.writeAll(oromoWords, ", ");
    return stringBuffer.toString();
  }

  String exampleToString() {
    if (example == null || example!.isEmpty)
      return "";
    else if (phrase == null || phrase!.isEmpty) return example!;
    return "($example)";
  }

  @override
  String toString() {
    return "$id $phrase";
  }
}
