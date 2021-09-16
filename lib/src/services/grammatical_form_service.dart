import 'dart:convert';

import 'package:http/http.dart' show Client;
import '../models/grammatical_form.dart';
import 'api.dart';
import 'phrase_service.dart';

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
