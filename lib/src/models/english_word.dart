import '../viewmodels/grammatical_form_view_models/grammatical_form_view_model.dart';

class EnglishWord {
  late final int id;
  late final String word;
  late final String phonetic;
  List<GrammaticalFormViewModel>? forms;
  Map<String, List<String>> definitions = new Map();
  String? audio;

  EnglishWord(this.id, this.word, this.phonetic);

  factory EnglishWord.fromJson(Map<String, dynamic> parsedJson) {
    return EnglishWord(
      parsedJson['id'],
      parsedJson['word'],
      parsedJson['phonetic'],
    );
  }
}
