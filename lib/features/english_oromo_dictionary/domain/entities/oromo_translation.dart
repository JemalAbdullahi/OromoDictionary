import 'package:equatable/equatable.dart';

class OromoTranslation extends Equatable {
  // final int id;
  // final int phraseID;
  final String translation;

  OromoTranslation(
      {
        //required this.id, 
        //required this.phraseID, 
        required this.translation});

  @override
  List<Object?> get props => [translation];
}
