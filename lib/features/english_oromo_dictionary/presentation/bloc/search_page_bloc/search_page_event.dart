part of 'search_page_bloc.dart';

abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();
}

class GetListForEnglishWord extends SearchPageEvent {
  final String englishTerm;

  ///Retrieves Search Results for the englishTerm inputted.
  ///
  ///englishTerm: String
  GetListForEnglishWord(this.englishTerm);

  @override
  List<Object?> get props => [englishTerm];
}

class GetListForOromoWord extends SearchPageEvent {
  final String oromoTerm;

  ///Retrieves the Search Results for the oromoTerm inputted.
  ///
  ///oromoTerm: String
  GetListForOromoWord(this.oromoTerm);

  @override
  List<Object?> get props => [oromoTerm];
}

class ChangeLanguageSelected extends SearchPageEvent {
  final bool isEnglish;

  ///Changes the Bloc's isEnglish field when the Language is changed.
  ///
  ///isEnglish: boolean.
  ChangeLanguageSelected({required this.isEnglish});

  @override
  List<Object?> get props => [isEnglish];
}
