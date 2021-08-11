import 'package:oromo_dictionary/src/models/english_word.dart';
import 'package:oromo_dictionary/src/services/english_definition_api.dart';
import 'package:oromo_dictionary/src/viewmodels/grammatical_form_view_models/grammatical_form_list_view_model.dart';
import 'package:oromo_dictionary/src/viewmodels/grammatical_form_view_models/grammatical_form_view_model.dart';

class EnglishWordViewModel {
  late final EnglishWord _englishWord;

  EnglishWordViewModel(this._englishWord);

  int get id {
    return this._englishWord.id;
  }

  String get word {
    return this._englishWord.word;
  }

  String get phonetic {
    return this._englishWord.phonetic;
  }

  String? get audio {
    return this._englishWord.audio;
  }

  Map<String, List<String>> get definitions{
    return this._englishWord.definitions;
  }

  List<GrammaticalFormViewModel>? get forms {
    return this._englishWord.forms;
  }

  set forms(List<GrammaticalFormViewModel>? grammaticalForms) {
    this._englishWord.forms = grammaticalForms;
  }

  setForms() async {
    if (forms == null) {
      final grammaticalForms =
          await GrammaticalFormListViewModel.fetchGrammaticalForms(id);
      forms = grammaticalForms;
      EnglishDefinitionAPI.fetchEnglishDefinition(this._englishWord);
      for (GrammaticalFormViewModel form in forms!) {
        await form.setPhrases();
      }
    }
  }
}
