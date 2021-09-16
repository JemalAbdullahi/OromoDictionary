import 'package:equatable/equatable.dart';

class EnglishDictionaryDef extends Equatable {
  final String word;
  final Map? phonetics;
  final String? origin;
  final List<dynamic> meanings;

  EnglishDictionaryDef(
      {required this.word,
      required this.phonetics,
      required this.origin,
      required this.meanings});

  @override
  List<Object?> get props => [word, phonetics, origin, meanings];
}
