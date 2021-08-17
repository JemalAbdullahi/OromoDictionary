class EnglishDictionaryDef {
  final String word;
  final Map? phonetics;
  final String? origin;
  final List<dynamic> meanings;

  EnglishDictionaryDef(
      this.word, this.phonetics, this.origin, this.meanings);

  factory EnglishDictionaryDef.fromJson(Map<String, dynamic> parsedJson) {
    return EnglishDictionaryDef(
      parsedJson["word"],
      parsedJson["phonetics"].isNotEmpty ? parsedJson["phonetics"][0] : null,
      parsedJson["origin"],
      parsedJson["meanings"],
    );
  }
}
