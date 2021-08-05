import 'package:oromo_dictionary/services/oromo_translation_service.dart';
import 'package:oromo_dictionary/viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class OromoTranslationListViewModel {
  List<OromoTranslationViewModel> translations = [];

  Future<List<OromoTranslationViewModel>> fetchOromoTranslations(
      int phraseID) async {
    final results =
        await OromoTranslationService().fetchOromoTranslations(phraseID);
    this.translations = results.map((item) => item).toList();
    return translations;
  }
}
