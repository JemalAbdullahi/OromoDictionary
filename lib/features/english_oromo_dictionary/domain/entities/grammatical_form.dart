import 'package:equatable/equatable.dart';

class GrammaticalForm extends Equatable {
  //late final int id;
  //late final int wordID;
  late final String partOfSpeech;
  // List<PhraseViewModel>? phrases;

  GrammaticalForm(
      {
        // required this.id, 
        // required this.wordID,
        required this.partOfSpeech});

  @override
  List<Object?> get props => [partOfSpeech];
}
