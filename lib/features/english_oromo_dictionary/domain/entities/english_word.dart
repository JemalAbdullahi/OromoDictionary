import 'package:equatable/equatable.dart';

import 'grammatical_form.dart';

// ignore: must_be_immutable
class EnglishWord extends Equatable {
  final int id;
  final String word;
  final String phonetic;
  late final List<GrammaticalForm> forms;
  late Map<String, List<String>> definitions = new Map();
  late final String? audio;

  EnglishWord({required this.id, required this.word, required this.phonetic});

  @override
  List<Object?> get props => [word, phonetic];
}
