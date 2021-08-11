import 'package:http/http.dart' show Client;
import 'package:oromo_dictionary/src/models/english_dictionary_def.dart';
import 'dart:convert';

import 'package:oromo_dictionary/src/models/english_word.dart';

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
      print(englishDictionaryDef.word);
      /* englishWord.audio = result[0]["phonetics"][0]["audio"];
      for (Map<String, dynamic> meaning in result[0]["meanings"][0]) {
        for (Map<String, dynamic> definition in meaning['definitions']) {
          definitions.add(definition['definition']);
        }
        print(definitions.toString());
        englishWord.definitions[meaning['partOfSpeech']] = definitions;
        definitions = []; */
      // }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
