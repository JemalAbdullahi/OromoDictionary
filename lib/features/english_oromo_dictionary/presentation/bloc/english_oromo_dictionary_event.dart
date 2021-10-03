part of 'english_oromo_dictionary_bloc.dart';

abstract class EnglishOromoDictionaryEvent extends Equatable {
  const EnglishOromoDictionaryEvent();
}

class GetListForEnglishWord extends EnglishOromoDictionaryEvent {
  final String englishTerm;
  ///Retrieves Search Results for the englishTerm inputted.
  ///
  ///englishTerm: String
  GetListForEnglishWord(this.englishTerm);

  @override
  List<Object?> get props => [englishTerm];
}

class GetListForOromoWord extends EnglishOromoDictionaryEvent {
  final String oromoTerm;
  ///Retrieves the Search Results for the oromoTerm inputted.
  ///
  ///oromoTerm: String
  GetListForOromoWord(this.oromoTerm);

  @override
  List<Object?> get props => [oromoTerm];
}

class ChangeLanguageSelected extends EnglishOromoDictionaryEvent {
  final bool isEnglish;
  ///Changes the Bloc's isEnglish field when the Language is changed.
  ///
  ///isEnglish: boolean.
  ChangeLanguageSelected({required this.isEnglish});

  @override
  List<Object?> get props => [isEnglish];
}
