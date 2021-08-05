import 'package:oromo_dictionary/models/grammatical_form.dart';
import 'package:oromo_dictionary/viewmodels/phrase_view_models/phrase_view_model.dart';

class GrammaticalFormViewModel {
  late final GrammaticalForm _grammaticalForm;

  GrammaticalFormViewModel(this._grammaticalForm);

  int get id {
    return this._grammaticalForm.id;
  }

  String get partOfSpeech {
    return this._grammaticalForm.partOfSpeech;
  }

  int get wordID {
    return this._grammaticalForm.wordID;
  }

  List<PhraseViewModel> get phrases {
    return this._grammaticalForm.phrases;
  }
}
