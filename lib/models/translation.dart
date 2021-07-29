class MainEntry {
  late final String mainEntry;
  late final String phonetic;
  late final List<SubEntry> subentries;

  MainEntry(this.mainEntry, this.phonetic);

  factory MainEntry.fromJson(Map<String, dynamic> parsedJson) {
    return MainEntry(
      parsedJson['mainEntry'],
      parsedJson['phonetic'],
    );
  }
}

class SubEntry {
  late final String partOfSpeech;
  late List<Phrase> phrases;

  SubEntry(this.partOfSpeech);
}

class Phrase {
  late final String phrase;
  late final List<String> translations;
  late final String example;

  Phrase(this.phrase, this.translations, {this.example = ""});

  String translationToString() {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.writeAll(translations, ", ");
    return stringBuffer.toString();
  }

  String exampleToString() {
    if(example.isEmpty) return example;
    return phrase.isEmpty ? example : "($example)";
  }
}
