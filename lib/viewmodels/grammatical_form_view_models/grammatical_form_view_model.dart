import 'package:oromo_dictionary/models/grammatical_form.dart';
import 'package:oromo_dictionary/viewmodels/phrase_view_models/phrase_list_view_model.dart';
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

  List<PhraseViewModel>? get phrases {
    return this._grammaticalForm.phrases;
  }

  set phrases(List<PhraseViewModel>? phrases) {
    this._grammaticalForm.phrases = phrases;
  }

  setPhrases() async {
    if (phrases == null) {
      final phrase =
          await PhraseListViewModel.fetchPhrases(id);
      phrases = phrase;
      for (PhraseViewModel phrase in phrases!) {
        await phrase.setTranslations();
      }
    }
  }

  @override
  String toString() {
    return "$id $partOfSpeech";
  }
}
