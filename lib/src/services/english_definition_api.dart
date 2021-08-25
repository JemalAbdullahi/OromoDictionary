import 'package:http/http.dart' show Client, Response;
import 'package:oromo_dictionary/src/models/english_dictionary_def.dart';
import 'dart:convert';

import 'package:oromo_dictionary/src/models/english_word.dart';
import 'package:oromo_dictionary/src/viewmodels/english_dictionary_def/english_dictionary_def_view_model.dart';

class EnglishDefinitionAPI {
  static Client client = Client();
  static String api = 'api.dictionaryapi.dev';
  static Uri dictionaryURL = Uri(scheme: 'https', host: api);

  static List<String> pathSeg = ['api', 'v2', 'entries', 'en'];
  static void resetPathSeg() => pathSeg = ['api', 'v2', 'entries', 'en'];

  static Future<void> fetchEnglishDefinition(EnglishWord englishWord) async {
    resetPathSeg();
    pathSeg.add(englishWord.word);
    final Response response = await client
        .get(dictionaryURL.replace(pathSegments: pathSeg))
        .timeout(Duration(seconds: 5), onTimeout: () {
      englishWord.audio = "";
      return Response("Error", 500);
    });
    resetPathSeg();
    if (response.statusCode == 200) {
      final List<dynamic> result = json.decode(response.body);
      EnglishDictionaryDef englishDictionaryDef =
          EnglishDictionaryDef.fromJson(result[0]);
      EnglishDictionaryDefViewModel englishDictionaryDefViewModel =
          EnglishDictionaryDefViewModel(englishDictionaryDef);
      englishWord.audio = englishDictionaryDefViewModel.audio;
      englishWord.definitions = englishDictionaryDefViewModel.definitions;
      print(englishWord.definitions.toString());
    } else if (response.statusCode != 500) {
      throw Exception(response.reasonPhrase);
    }
  }
}
