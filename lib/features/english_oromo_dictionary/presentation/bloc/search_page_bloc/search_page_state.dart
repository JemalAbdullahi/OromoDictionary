part of 'search_page_bloc.dart';


class Loaded extends PageState {
  final List<dynamic> wordList;

  Loaded({required this.wordList});
  @override
  List<Object> get props => [wordList];
}
