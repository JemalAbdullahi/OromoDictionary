import 'package:oromo_dictionary/src/models/oromo_translation.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';

class OromoTranslationViewModel {
  late final OromoTranslation _oromoTranslation;

  OromoTranslationViewModel(this._oromoTranslation);

  int get id {
    return this._oromoTranslation.id;
  }

  String get translation {
    return this._oromoTranslation.translation;
  }

  int get phraseID {
    return this._oromoTranslation.phraseID;
  }

  String translationBreakdown() {
    // Map<String, String> breakdown = new Map();
    StringBuffer sb = new StringBuffer();
    String letter;
    for (int i = 0; i < translation.length; i++) {
      if (translation[i] != " ") {
        int j = i < translation.length - 1 ? i + 1 : -1;
        letter = j != -1 ? translation[i] + translation[j] : translation[i];
        letter.trim();
        print(letter);
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

        if (i < translation.length - 1) {
          sb.write(",     ");
        }
      }
    }
    return sb.toString();
  }
}
