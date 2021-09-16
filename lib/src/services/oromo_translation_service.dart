import 'dart:convert';

import 'package:http/http.dart' show Client;
import '../models/oromo_translation.dart';
import 'api.dart';
import '../viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class OromoTranslationService {
  Client client = Client();

  List<OromoTranslationViewModel> translations = [];
  List<String> pathSegments = ['translation'];

  Future<List<OromoTranslationViewModel>> fetchOromoTranslations(
      int phraseID) async {
    pathSegments.add(phraseID.toString());
    final response =
        await client.get(API.searchURL.replace(pathSegments: pathSegments));
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          translations
              .add(OromoTranslationViewModel(OromoTranslation.fromJson(json_)));
        } catch (Exception) {
          print(Exception);
        }
      }
      return translations;
    } else
      throw Exception(result["status"]);
  }
}
