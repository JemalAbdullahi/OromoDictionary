import 'package:equatable/equatable.dart';
import 'oromo_translation.dart';

class Phrase extends Equatable {
  late final int id;
  late final int formID;
  late final String? phrase;
  late final String? example;
  late final List<OromoTranslation>? translations;

  Phrase(
      {
      required this.id,
      required this.formID,
      required this.phrase,
      required this.example});

  String exampleToString() {
    if (example == null || example!.isEmpty)
      return "";
    else if (phrase == null || phrase!.isEmpty) return example!;
    return "($example)";
  }

  String translationToString() {
    List<String> oromoWords = [];
    for (OromoTranslation oromoWord in translations!) {
      oromoWords.add(oromoWord.translation);
    }

    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.writeAll(oromoWords, ",\n");
    return stringBuffer.toString();
  }

  @override
  List<Object?> get props => [phrase, example];
}
