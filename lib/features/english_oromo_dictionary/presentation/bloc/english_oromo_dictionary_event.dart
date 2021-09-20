part of 'english_oromo_dictionary_bloc.dart';

abstract class EnglishOromoDictionaryEvent extends Equatable {
  const EnglishOromoDictionaryEvent();
}

class GetEnglishWordList extends EnglishOromoDictionaryEvent {
  final String englishTerm;

  GetEnglishWordList(this.englishTerm);

  @override
  List<Object?> get props => [englishTerm];
}
class GetOromoWordList extends EnglishOromoDictionaryEvent {
  final String oromoTerm;

  GetOromoWordList(this.oromoTerm);

  @override
  List<Object?> get props => [oromoTerm];
}
