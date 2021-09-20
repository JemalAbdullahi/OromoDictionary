part of 'english_oromo_dictionary_bloc.dart';

abstract class EnglishOromoDictionaryState extends Equatable {
  const EnglishOromoDictionaryState();
}

class Empty extends EnglishOromoDictionaryState {
  @override
  List<Object> get props => [];
}

class Loading extends EnglishOromoDictionaryState {
  @override
  List<Object> get props => [];
}

class Loaded extends EnglishOromoDictionaryState {
  final List<dynamic> wordList;

  Loaded({required this.wordList});
  @override
  List<Object> get props => [wordList];
}

class Error extends EnglishOromoDictionaryState {
  final String message;

  Error({required this.message});
  @override
  List<Object> get props => [message];
}
