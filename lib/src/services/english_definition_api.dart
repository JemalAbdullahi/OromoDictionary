import 'package:http/http.dart' show Client;
import 'package:oromo_dictionary/src/models/english_dictionary_def.dart';
import 'dart:convert';

import 'package:oromo_dictionary/src/models/english_word.dart';
import 'package:oromo_dictionary/src/viewmodels/english_dictionary_def.dart/english_dictionary_def_view_model.dart';

class EnglishDefinitionAPI {
  static Client client = Client();
  static String api = 'api.dictionaryapi.dev';
  static Uri dictionaryURL = Uri(scheme: 'https', host: api);

  static List<String> pathSeg = ['api', 'v2', 'entries', 'en_US'];
  static void resetPathSeg() => pathSeg = ['api', 'v2', 'entries', 'en_US'];

  static Future<void> fetchEnglishDefinition(EnglishWord englishWord) async {
    pathSeg.add(englishWord.word);
    // List<String> definitions = [];
    final response =
        await client.get(dictionaryURL.replace(pathSegments: pathSeg));
    resetPathSeg();
    final List<dynamic> result = json.decode(response.body);
    if (response.statusCode == 200) {
      EnglishDictionaryDef englishDictionaryDef =
          EnglishDictionaryDef.fromJson(result[0]);
      EnglishDictionaryDefViewModel englishDictionaryDefViewModel =
          EnglishDictionaryDefViewModel(englishDictionaryDef);
      englishWord.audio = englishDictionaryDefViewModel.audio;
      englishWord.definitions = englishDictionaryDefViewModel.definitions;
      print(englishWord.definitions.toString());
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
