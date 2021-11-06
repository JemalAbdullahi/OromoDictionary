import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/models/english_dictionary_def_model.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_dictionary_def.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/english_word.dart';
import '../../domain/entities/oromo_translation.dart';
import '../models/english_word_model.dart';
import '../models/oromo_translation_model.dart';

abstract class EnglishOromoDictionaryRemoteDataSource {
  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/om/{oromoTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<OromoTranslation>> getOromoWordList(String oromoTerm);

  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/en/{englishTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<EnglishWord>> getEnglishWordList(String englishTerm);

  ///Calls the https://oromo-dictionary-staging.herokuapp.com/search/en/{englishTerm} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<EnglishWord>> getEnglishTranslations(String oromoWord);
}

class EnglishOromoDictionaryRemoteDataSourceImpl
    implements EnglishOromoDictionaryRemoteDataSource {
  final http.Client client;

  EnglishOromoDictionaryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EnglishWord>> getEnglishWordList(String englishTerm) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/en/$englishTerm');
    return _getWordListFromURI<EnglishWord>(uri, isEnglish: true);
  }

  @override
  Future<List<EnglishWord>> getEnglishTranslations(String oromoWord) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/word/$oromoWord');
    return _getWordListFromURI<EnglishWord>(uri, isEnglish: true);
  }

  @override
  Future<List<OromoTranslation>> getOromoWordList(String oromoTerm) {
    Uri uri = Uri(
        scheme: 'https',
        host: 'oromo-dictionary-staging.herokuapp.com',
        path: '/search/om/$oromoTerm');
    return _getWordListFromURI<OromoTranslation>(uri, isEnglish: false);
  }

  Future<List<T>> _getWordListFromURI<T>(Uri uri,
      {required bool isEnglish}) async {
    final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final List<T> wordList =
          await _parseSearchResults(result['data'], isEnglish: isEnglish) as List<T>;
      return wordList;
    } else {
      throw ServerException();
    }
  }

  Future<List> _parseSearchResults(List<dynamic> data,
      {required bool isEnglish}) async {
    List<dynamic> words = [];
    for (Map<String, dynamic> json_ in data) {
      try {
        if (isEnglish) {
          EnglishWord englishWord = EnglishWordModel.fromJson(json_);
          await getEnglishDefinitions(englishWord);
          words.add(englishWord);
        } else {
          words.add(OromoTranslationModel.fromJson(json_));
        }
      } catch (Exception) {
        print(Exception);
      }
    }
    return words;
  }

  Future<void> getEnglishDefinitions(EnglishWord englishWord) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'api.dictionaryapi.dev',
        path: '/api/v2/entries/en/${englishWord.word}');
    final response = await client
        .get(uri, headers: {'Content-Type': 'application/json'}).timeout(
            Duration(seconds: 5), onTimeout: () {
      englishWord.audio = "";
      return http.Response("Error", 500);
    });

    if (response.statusCode == 200) {
      final List<dynamic> result = json.decode(response.body);
      EnglishDictionaryDef englishDictionaryDef =
          EnglishDictionaryDefModel.fromJson(result[0]);
      englishWord.audio = englishDictionaryDef.phoneticAudio;
      englishWord.definitions = convertMeanings(englishDictionaryDef.meanings);
    } else if (response.statusCode != 500) {
      throw ServerException();
    }
  }

  Map<String, List<String>> convertMeanings(List meanings) {
    Map<String, List<String>> definitions = new Map();
    for (dynamic meaning in meanings) {
      List<String> definition = [];
      for (Map<String, dynamic> def in meaning["definitions"]) {
        definition.add(def["definition"]);
      }
      definitions[meaning["partOfSpeech"]] = definition;
    }
    return definitions;
  }
}
