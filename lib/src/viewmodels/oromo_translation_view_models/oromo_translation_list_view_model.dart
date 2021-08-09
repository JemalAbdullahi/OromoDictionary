import 'package:oromo_dictionary/src/services/oromo_translation_service.dart';
import 'package:oromo_dictionary/src/viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class OromoTranslationListViewModel {
  static Future<List<OromoTranslationViewModel>> fetchOromoTranslations(
      int phraseID) async {
    final results =
        await OromoTranslationService().fetchOromoTranslations(phraseID);
    return results.map((item) => item).toList();
  }
}
