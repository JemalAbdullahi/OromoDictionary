part of 'english_translation_page_bloc.dart';

class Loaded extends PageState {
  final EnglishWord englishWord;
  //phonetic string

  Loaded({required this.englishWord});
  @override
  List<Object> get props => [englishWord];
}
