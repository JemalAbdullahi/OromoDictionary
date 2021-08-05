import 'package:oromo_dictionary/services/phrase_service.dart';
import 'package:oromo_dictionary/viewmodels/phrase_view_models/phrase_view_model.dart';

class PhraseListViewModel {
  List<PhraseViewModel> phrases = [];

  Future<List<PhraseViewModel>> fetchPhrases(int formID) async {
    final results =
        await PhraseService().fetchPhrases(formID);
    this.phrases = results.map((item) => item).toList();
    return this.phrases;
  }
}
