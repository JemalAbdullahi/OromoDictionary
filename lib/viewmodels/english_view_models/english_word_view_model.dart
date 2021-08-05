import 'package:oromo_dictionary/models/english_word.dart';
import 'package:oromo_dictionary/viewmodels/grammatical_form_view_models/grammatical_form_view_model.dart';

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

  List<GrammaticalFormViewModel> get forms {
    return this._englishWord.forms;
  }

  set forms(List<GrammaticalFormViewModel> grammaticalForms) {
    forms = grammaticalForms;
  }
}
