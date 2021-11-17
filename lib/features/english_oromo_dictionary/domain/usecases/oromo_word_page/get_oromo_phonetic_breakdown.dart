import '../../../../../core/presentation/util/constants.dart';

class GetOromoPhoneticBreakdown {
  StringBuffer _stringBuffer = new StringBuffer();
  int _increment = 0;

  ///Breaks down a given oromo word's pronunciation letter by letter
  String call({String oromoWord = ''}) {
    String letter;
    String _seperator = "";
    _stringBuffer.clear();
    for (int index = 0; index < oromoWord.length; index++) {
      _increment = -1;
      if (isNotSpace(oromoWord, index)) {
        int nextIndex = getNextCharacterIndex(index, oromoWord);
        letter = getLettersToEvaluate(nextIndex, oromoWord, index);
        letter.trim();
        _stringBuffer.write(_seperator);
        appendAppropriateDescription(letter);
        _seperator = ",   ";
        index += _increment;
      }
    }

    return _stringBuffer.toString();
  }

  void appendAppropriateDescription(String letter) {
    appendUniqueConsonant(letter);
    appendLongVowel(letter);
    appendShortVowel(letter);
    appendConsonant(letter);
  }

  void appendUniqueConsonant(String letter) {
    if (hasNotAppended && uniqueConsonantsHas(letter)) {
      writeUniqueConsonantDescription(letter);
      _increment = 1;
    }
  }

  bool get hasNotAppended => _increment == -1;

  void appendLongVowel(String letter) {
    if (hasNotAppended && longVowelsHas(letter)) {
      writeLongVowelDescription(letter);
      _increment = 1;
    }
  }

  void appendShortVowel(String letter) {
    if (hasNotAppended && shortVowelsHas(letter[0])) {
      writeShortVowelDescription(letter[0]);
      _increment = 0;
    }
  }

  void appendConsonant(String letter) {
    if (hasNotAppended && consonantsHas(letter[0])) {
      if (isRepeated(letter)) {
        writeLongerSound(letter);
        _increment = 1;
      } else {
        writeConsonant(letter);
        _increment = 0;
      }
    }
  }

  void writeConsonant(String letter) {
    _stringBuffer.write(letter[0] + ": ");
    _stringBuffer.write(consonants[letter[0]]!);
  }

  bool isRepeated(String letter) =>
      letter.length == 2 && letter[0] == letter[1];

  void writeLongerSound(String letter) {
    _stringBuffer.write("(Longer Sound) " + letter + ": ");
    _stringBuffer.write(consonants[letter[0]]!);
  }

  bool isNotSpace(String oromoWord, int index) => oromoWord[index] != " ";

  int getNextCharacterIndex(int index, String oromoWord) =>
      index < oromoWord.length - 1 ? index + 1 : -1;

  String getLettersToEvaluate(int nextIndex, String oromoWord, int index) =>
      nextIndex != -1
          ? oromoWord[index] + oromoWord[nextIndex]
          : oromoWord[index];

  bool uniqueConsonantsHas(String letter) =>
      uniqueConsonants.containsKey(letter);

  void writeUniqueConsonantDescription(String letter) {
    _stringBuffer.write(letter + ": ");
    _stringBuffer.write(uniqueConsonants[letter]!);
  }

  bool longVowelsHas(String letter) => longVowels.containsKey(letter);

  void writeLongVowelDescription(String letter) {
    _stringBuffer.write(letter + ": ");
    _stringBuffer.write(longVowels[letter]!);
  }

  bool shortVowelsHas(String letter) => shortVowels.containsKey(letter);

  void writeShortVowelDescription(String letter) {
    _stringBuffer.write(letter + ": ");
    _stringBuffer.write(shortVowels[letter]!);
  }

  bool consonantsHas(String letter) => consonants.containsKey(letter);

  void writeConsonantDescription(String letter) {
    _stringBuffer.write(letter + ": ");
    _stringBuffer.write(consonants[letter]!);
  }
}
