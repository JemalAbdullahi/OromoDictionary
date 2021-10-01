part of 'english_oromo_dictionary_bloc.dart';

abstract class EnglishOromoDictionaryEvent extends Equatable {
  const EnglishOromoDictionaryEvent();
}

class GetListForEnglishWord extends EnglishOromoDictionaryEvent {
  final String englishTerm;

  GetListForEnglishWord(this.englishTerm);

  @override
  List<Object?> get props => [englishTerm];
}

class GetListForOromoWord extends EnglishOromoDictionaryEvent {
  final String oromoTerm;

  GetListForOromoWord(this.oromoTerm);

  @override
  List<Object?> get props => [oromoTerm];
}

class ChangeLanguageSelected extends EnglishOromoDictionaryEvent {
  final bool isEnglish;

  ChangeLanguageSelected({required this.isEnglish});

  @override
  List<Object?> get props => [isEnglish];
}
