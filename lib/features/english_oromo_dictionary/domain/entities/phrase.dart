import 'package:equatable/equatable.dart';

class Phrase extends Equatable {
  // late final int id;
  // late final int formID;
  late final String? phrase;
  late final String? example;
  //List<OromoTranslationViewModel>? translations;

  Phrase(
      {
      // required this.id,
      // required this.formID,
      required this.phrase,
      required this.example});

  @override
  List<Object?> get props => [phrase, example];
}
