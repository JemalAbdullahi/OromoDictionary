import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:oromo_dictionary/models/phrase.dart';
import 'package:oromo_dictionary/services/api.dart';
import 'package:oromo_dictionary/services/oromo_translation_service.dart';
import 'package:oromo_dictionary/viewmodels/phrase_view_models/phrase_view_model.dart';

class PhraseService {
  Client client = Client();
  

  List<PhraseViewModel> phrases = [];
  List<String> pathSegments = ['phrase'];

  Future<List<PhraseViewModel>> fetchPhrases(int formID) async {
    pathSegments.add(formID.toString());
    final response =
        await client.get(API.searchURL.replace(pathSegments: pathSegments));
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          Phrase phrase = Phrase.fromJson(json_);
          phrase.translations =
              await OromoTranslationService().fetchOromoTranslations(phrase.id);
          
          phrases.add(PhraseViewModel(phrase));
        } catch (Exception) {
          print(Exception);
        }
      }
      return phrases;
    } else
      throw Exception(result["status"]);
  }
}
