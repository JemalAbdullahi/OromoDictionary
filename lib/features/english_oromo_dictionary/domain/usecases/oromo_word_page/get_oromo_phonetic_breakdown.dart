import '../../../../../core/presentation/util/constants.dart';
///Breaks down a given oromo word's pronunciation letter by letter
class GetOromoPhoneticBreakdown {
  String call({String oromoWord = ''}) {
    StringBuffer sb = new StringBuffer();
    String letter;
    for (int i = 0; i < oromoWord.length; i++) {
      if (oromoWord[i] != " ") {
        int j = i < oromoWord.length - 1 ? i + 1 : -1;
        letter = j != -1 ? oromoWord[i] + oromoWord[j] : oromoWord[i];
        letter.trim();
        if (uniqueConsonants.containsKey(letter)) {
          sb.write(letter + ": ");
          sb.write(uniqueConsonants[letter]!);
          i++;
        } else if (longVowels.containsKey(letter)) {
          sb.write(letter + ": ");
          sb.write(longVowels[letter]!);
          i++;
        } else if (shortVowels.containsKey(letter[0])) {
          sb.write(letter[0] + ": ");
          sb.write(shortVowels[letter[0]]!);
        } else if (consonants.containsKey(letter[0])) {
          if (letter.length == 2 && letter[0] == letter[1]) {
            sb.write("(Longer Sound) " + letter + ": ");
            i++;
          } else {
            sb.write(letter[0] + ": ");
          }
          sb.write(consonants[letter[0]]!);
        }

        if (i < oromoWord.length - 1) {
          sb.write(", ");
        }
      }
    }
    return sb.toString();
  }
}
