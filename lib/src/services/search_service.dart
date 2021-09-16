import 'dart:convert';

import 'package:http/http.dart' show Client;
import '../models/oromo_translation.dart';
import 'api.dart';
import '../models/english_word.dart';

class SearchService {
  Client client = Client();

  List<String> pathSegments = ['search', API.language];

  Future<List> fetchWords(String keyword) async {
    pathSegments.add(keyword);
    final response =
        await client.get(API.searchURL.replace(pathSegments: pathSegments));
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (API.isEnglish()) return parseEnglishResults(result["data"]);
      if (API.isOromo()) return parseOromoResults(result["data"]);
      return [];
    } else
      throw Exception(result["status"]);
  }

  Future<List<EnglishWord>> fetchEnglishWords(String oromoWord) async {
    List<String> pathSegments = ['word', oromoWord];
    final response =
        await client.get(API.searchURL.replace(pathSegments: pathSegments));
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      return parseEnglishResults(result["data"]);
    } else
      throw Exception(result["status"]);
  }

  List<EnglishWord> parseEnglishResults(List<dynamic> data) {
    List<EnglishWord> englishWords = [];
    for (Map<String, dynamic> json_ in data) {
      try {
        englishWords.add(EnglishWord.fromJson(json_));
      } catch (Exception) {
        print(Exception);
      }
    }
    return englishWords;
  }

  List<OromoTranslation> parseOromoResults(List<dynamic> data) {
    List<OromoTranslation> oromoTranslations = [];
    for (Map<String, dynamic> json_ in data) {
      try {
        oromoTranslations.add(OromoTranslation.fromJson(json_));
      } catch (Exception) {
        print(Exception);
      }
    }
    return oromoTranslations;
  }
}
