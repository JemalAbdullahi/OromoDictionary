import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:oromo_dictionary/models/grammatical_form.dart';
import 'package:oromo_dictionary/services/api.dart';
import 'package:oromo_dictionary/services/phrase_service.dart';

class GrammaticalFormService {
  Client client = Client();

  List<GrammaticalForm> forms = [];
  List<String> pathSegments = ['grammaticalform'];

  Future<List<GrammaticalForm>> fetchGrammaticalForms(int wordID) async {
    pathSegments.add(wordID.toString());
    final response =
        await client.get(API.searchURL.replace(pathSegments: pathSegments));
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          GrammaticalForm form = GrammaticalForm.fromJson(json_);
          form.phrases = await PhraseService().fetchPhrases(form.id);
          forms.add(form);
        } catch (Exception) {
          print(Exception);
        }
      }
      return forms;
    } else
      throw Exception(result["status"]);
  }
}
