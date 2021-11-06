import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/grammatical_form_model.dart';
import '../models/oromo_translation_model.dart';
import '../models/phrase_model.dart';
import '../../domain/entities/grammatical_form.dart';
import '../../domain/entities/oromo_translation.dart';
import '../../domain/entities/phrase.dart';

abstract class EnglishDefinitionRemoteDataSource {
  ///Calls the https://oromo-dictionary-staging.herokuapp.com/translation/{phraseID} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<OromoTranslation>> getOromoWordList(int phraseID);

  ///Calls the https://oromo-dictionary-staging.herokuapp.com/grammaticalform/{wordID} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<GrammaticalForm>> getGrammaticalFormList(int wordID);

  ///Calls the https://oromo-dictionary-staging.herokuapp.com/phrase/{formID} endpoint.
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<Phrase>> getPhraseList(int formID);
}

class EnglishDefinitionRemoteDataSourceImpl
    implements EnglishDefinitionRemoteDataSource {
  final String scheme = 'https';
  final String host = 'oromo-dictionary-staging.herokuapp.com';
  final http.Client client;

  EnglishDefinitionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GrammaticalForm>> getGrammaticalFormList(int wordID) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/grammaticalform/$wordID');
    List<GrammaticalForm> forms = [];
    final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final Map result = json.decode(response.body);
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          GrammaticalForm form = GrammaticalFormModel.fromJson(json_);
          form.phrases = await getPhraseList(form.id);
          forms.add(form);
        } catch (Exception) {
          print(Exception);
        }
      }
      return forms;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Phrase>> getPhraseList(int formID) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/phrase/$formID');
    List<Phrase> phrases = [];
    final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    //Parse Results into Phrase List
    if (response.statusCode == 200) {
      final Map result = json.decode(response.body);
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          Phrase phrase = PhraseModel.fromJson(json_);
          phrase.translations = await getOromoWordList(phrase.id);

          phrases.add(phrase);
        } catch (Exception) {
          print(Exception);
        }
      }
      return phrases;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OromoTranslation>> getOromoWordList(int phraseID) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/translation/$phraseID');
    List<OromoTranslation> translations = [];
    final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          translations
              .add(OromoTranslationModel.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      return translations;
    } else {
      throw ServerException();
    }
  }
}
