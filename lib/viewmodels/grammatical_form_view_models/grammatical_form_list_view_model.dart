import 'package:oromo_dictionary/services/grammatical_form_service.dart';
import 'package:oromo_dictionary/viewmodels/grammatical_form_view_models/grammatical_form_view_model.dart';

class GrammaticalFormListViewModel {
  List<GrammaticalFormViewModel> forms = [];

  Future<List<GrammaticalFormViewModel>> fetchGrammaticalForms(int wordID) async {
    final results =
        await GrammaticalFormService().fetchGrammaticalForms(wordID);
    this.forms = results.map((item) => GrammaticalFormViewModel(item)).toList();
    return forms;
  }
}
