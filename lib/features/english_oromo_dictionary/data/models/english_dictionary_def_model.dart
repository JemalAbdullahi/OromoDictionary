import '../../domain/entities/english_dictionary_def.dart';

class EnglishDictionaryDefModel extends EnglishDictionaryDef {
  EnglishDictionaryDefModel({
    required String word,
    required Map? phonetics,
    required String? origin,
    required List<dynamic> meanings,
  }) : super(
            word: word, phoneticAudio: phonetics!["audio"], meanings: meanings);

  factory EnglishDictionaryDefModel.fromJson(List<dynamic> parsedJson) {
    return EnglishDictionaryDefModel(
      word: parsedJson[0]["word"],
      phonetics: parsedJson[0]["phonetics"].isNotEmpty
          ? parsedJson[0]["phonetics"][0]
          : null,
      origin: parsedJson[0]["origin"],
      meanings: parsedJson[0]["meanings"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "word": word,
      "phonetic_audio": phoneticAudio,
      "meanings": meanings,
    };
  }
}
