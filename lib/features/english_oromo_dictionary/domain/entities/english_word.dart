import 'package:equatable/equatable.dart';

class EnglishWord extends Equatable {
  //final int id;
  final String word;
  final String phonetic;
  //List<GrammaticalFormViewModel>? forms;
  //Map<String, List<String>> definitions = new Map();
  //String? audio;

  EnglishWord({ required this.word, required this.phonetic});

  @override
  List<Object?> get props => [word, phonetic];
}
