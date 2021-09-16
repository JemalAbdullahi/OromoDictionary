import 'package:equatable/equatable.dart';

class EnglishDictionaryDef extends Equatable {
  final String word;
  final String? phoneticAudio;
  //final String? origin;
  final List<dynamic> meanings;

  EnglishDictionaryDef(
      {required this.word,
      required this.phoneticAudio,
      //required this.origin,
      required this.meanings});

  @override
  List<Object?> get props => [word, phoneticAudio, meanings];
}
