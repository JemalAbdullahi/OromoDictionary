part of 'oromo_translation_page_bloc.dart';


class Loaded extends PageState {
  final List<EnglishWord> wordList;
  //phonetic string

  Loaded({required this.wordList});
  @override
  List<Object> get props => [wordList];
}
