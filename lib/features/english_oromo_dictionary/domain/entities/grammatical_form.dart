import 'package:equatable/equatable.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/domain/entities/phrase.dart';

class GrammaticalForm extends Equatable {
  late final int id;
  late final int wordID;
  late final String partOfSpeech;
  List<Phrase>? phrases;

  GrammaticalForm(
      {
        required this.id, 
        required this.wordID,
        required this.partOfSpeech});

  @override
  List<Object?> get props => [id, wordID, partOfSpeech];
}
