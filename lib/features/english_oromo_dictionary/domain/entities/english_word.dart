import 'package:equatable/equatable.dart';

import 'grammatical_form.dart';

class EnglishWord extends Equatable {
  final int id;
  final String word;
  final String phonetic;
  List<GrammaticalForm>? forms;
  Map<String, List<String>> definitions = new Map();
  String? audio;

  EnglishWord({required this.id, required this.word, required this.phonetic});

  @override
  List<Object?> get props => [word, phonetic];
}
