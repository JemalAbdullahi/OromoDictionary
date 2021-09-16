import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';

class EnglishWordModel extends EnglishWord {
  EnglishWordModel({
    required id,
    required word,
    required phonetic,
  }) : super(id: id, word: word, phonetic: phonetic);
}
