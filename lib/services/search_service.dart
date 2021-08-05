import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:oromo_dictionary/services/api.dart';
import 'package:oromo_dictionary/models/english_word.dart';

class SearchService {
  Client client = Client();

  List<EnglishWord> englishWords = [];
  List<String> pathSegments = ['search'];

  Future<List<EnglishWord>> fetchEnglishWords(String keyword) async {
    pathSegments.add(keyword);
    final response =
        await client.get(API.searchURL.replace(pathSegments: pathSegments));
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          englishWords.add(EnglishWord.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      return englishWords;
    } else
      throw Exception(result["status"]);
  }
}
