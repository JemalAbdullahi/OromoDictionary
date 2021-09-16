import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/english_word.dart';

class EnglishWordModel extends EnglishWord {
  EnglishWordModel({
    required id,
    required word,
    required phonetic,
  }) : super(word: word, phonetic: phonetic);

  factory EnglishWordModel.fromJson(Map<String, dynamic> parsedJson) {
    return EnglishWordModel(
      id: parsedJson['id'],
      word: parsedJson['word'],
      phonetic: parsedJson['phonetic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"word": word, "phonetic": phonetic};
  }
}
