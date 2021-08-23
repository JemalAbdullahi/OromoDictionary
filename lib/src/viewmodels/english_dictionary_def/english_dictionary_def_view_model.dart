import 'package:oromo_dictionary/src/models/english_dictionary_def.dart';

class EnglishDictionaryDefViewModel {
  late final EnglishDictionaryDef _englishDictionaryDef;

  EnglishDictionaryDefViewModel(this._englishDictionaryDef);

  String get word {
    return _englishDictionaryDef.word;
  }

  String get audio {
    return _englishDictionaryDef.phonetics!=null ? _englishDictionaryDef.phonetics!["audio"] : "";
  }

  String? get origin {
    return _englishDictionaryDef.origin;
  }

  Map<String, List<String>> get definitions {
    Map<String, List<String>> definitions = new Map();
    for (dynamic meaning in _englishDictionaryDef.meanings) {
      List<String> definition = [];
      for (Map<String, dynamic> def in meaning["definitions"]) {
        definition.add(def["definition"]);
      }
      definitions[meaning["partOfSpeech"]] = definition;
    }
    return definitions;
  }
}
