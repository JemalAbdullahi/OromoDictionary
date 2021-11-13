import 'package:http/http.dart' as http;
import 'package:oromo_dictionary/features/english_oromo_dictionary/data/datasources/http_response.dart';
import '../models/english_dictionary_def_model.dart';
import '../../domain/entities/english_dictionary_def.dart';
import '../../domain/entities/english_word.dart';

import '../../../../core/error/exceptions.dart';
import '../models/grammatical_form_model.dart';
import '../models/oromo_translation_model.dart';
import '../models/phrase_model.dart';
import '../../domain/entities/grammatical_form.dart';
import '../../domain/entities/oromo_translation.dart';
import '../../domain/entities/phrase.dart';

abstract class EnglishWordRemoteDataSource {
  ///Gets an EnglishWord object complete with grammatical forms,
  /// phrases, definitions, and translations.
  /// 
  /// Calls various endpoints beginning with https://oromo-dictionary-staging.herokuapp.com/
  /// 
  ///Throws a [ServerException] for all error codes
  Future<EnglishWord> getEnglishWord(EnglishWord englishWord);

  
}

class EnglishWordRemoteDataSourceImpl
    implements EnglishWordRemoteDataSource {
  final String scheme = 'https';
  final String host = 'oromo-dictionary-staging.herokuapp.com';
  final http.Client client;
  late final HTTPResponse response;
  EnglishWord? englishWord;

  EnglishWordRemoteDataSourceImpl({required this.client}) {
    response = new HTTPResponse(client);
  }

  @override
  Future<EnglishWord> getEnglishWord(EnglishWord englishWord) async {
    _setEnglishWord(englishWord);
    await getEnglishDefinitions();
    await getGrammaticalFormList();
    return englishWord;
  }
  ///Sets the english word to be updated by this object
  _setEnglishWord(EnglishWord englishWord) {
    this.englishWord = englishWord;
  }

  Future<void> getEnglishDefinitions() async {
    await getEnglishDefinitionsResponse();
    response.isSuccessful()
        ? await successfulEnglishDefinitionResponse()
        : unsucessfulEnglishDefinitionResponse();
  }

  Future<void> getEnglishDefinitionsResponse() async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'api.dictionaryapi.dev',
        path: '/api/v2/entries/en/${englishWord!.word}');
    await response.setResponseWithTimeoutFrom(uri);
  }

  unsucessfulEnglishDefinitionResponse() {
    if (response.hasTimedOut()) {
      englishWord!.audio = "";
    }
    throw ServerException();
  }

  successfulEnglishDefinitionResponse() async {
    EnglishDictionaryDef englishDictionaryDef =
        EnglishDictionaryDefModel.fromJson(response.getResult());
    englishWord!.audio = englishDictionaryDef.phoneticAudio;
    englishWord!.definitions = _convertMeanings(englishDictionaryDef.meanings);
    //englishWord!.forms = await getGrammaticalFormList();
  }

  Map<String, List<String>> _convertMeanings(List meanings) {
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

  Future<List<GrammaticalForm>> getGrammaticalFormList() async {
    await getGrammaticalFormsResponse();
    return response.isSuccessful()
        ? successfulGrammaticalFormListResponse()
        : throw ServerException();
  }

  Future<void> getGrammaticalFormsResponse() async {
    Uri uri = Uri(
        scheme: scheme,
        host: host,
        path: '/grammaticalform/${englishWord!.id}');
    await response.setResponseFrom(uri);
  }

  Future<List<GrammaticalForm>> successfulGrammaticalFormListResponse() async {
    List<GrammaticalForm> forms = [];
    final Map result = response.getResult();
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
  }

  Future<List<Phrase>> getPhraseList(int formID) async {
    getPhrasesResponse(formID);
    return response.isSuccessful()
        ? successfulPhraseResponse()
        : throw ServerException();
  }

  Future<void> getPhrasesResponse(int formID) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/phrase/$formID');
    await response.setResponseFrom(uri);
  }

  successfulPhraseResponse() async {
    List<Phrase> phrases = [];
    final result = response.getResult();
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
  }

  Future<List<OromoTranslation>> getOromoWordList(int phraseID) async {
    await getOromoWordListResponse(phraseID);
    return response.isSuccessful()
        ? successfulOromoWordListResponse()
        : throw ServerException();
  }

  Future<void> getOromoWordListResponse(int phraseID) async {
    Uri uri = Uri(scheme: scheme, host: host, path: '/translation/$phraseID');
    await response.setResponseFrom(uri);
  }

  Future<List<OromoTranslation>> successfulOromoWordListResponse() async {
    List<OromoTranslation> translations = [];
    final Map result = response.getResult();
    for (Map<String, dynamic> json_ in result["data"]) {
      try {
        translations.add(OromoTranslationModel.fromJson(json_));
      } catch (Exception) {
        print(Exception);
      }
    }
    return translations;
  }
}
