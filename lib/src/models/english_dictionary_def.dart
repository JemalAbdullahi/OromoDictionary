class EnglishDictionaryDef {
  final String word;
  final String phonetic;
  final Map phonetics;
  final String? origin;
  final Map meanings;

  EnglishDictionaryDef(
      this.word, this.phonetic, this.phonetics, this.origin, this.meanings);

  factory EnglishDictionaryDef.fromJson(Map<String, dynamic> parsedJson) {
    return EnglishDictionaryDef(
      parsedJson["word"],
      parsedJson["phonetic"],
      parsedJson["phonetics"][0],
      parsedJson["origin"],
      parsedJson["meanings"][0],
    );
  }
}
