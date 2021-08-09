import 'package:oromo_dictionary/src/models/english_word.dart';
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
      for (GrammaticalFormViewModel form in forms!) {
        await form.setPhrases();
      }
    }
  }
}
