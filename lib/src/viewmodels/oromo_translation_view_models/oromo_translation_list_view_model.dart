import '../../services/oromo_translation_service.dart';
import 'oromo_translation_view_model.dart';

class OromoTranslationListViewModel {
  static Future<List<OromoTranslationViewModel>> fetchOromoTranslations(
      int phraseID) async {
    final results =
        await OromoTranslationService().fetchOromoTranslations(phraseID);
    return results.map((item) => item).toList();
  }
}
