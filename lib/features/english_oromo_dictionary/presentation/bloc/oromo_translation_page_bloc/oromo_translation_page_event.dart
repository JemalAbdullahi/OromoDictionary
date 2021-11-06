part of 'oromo_translation_page_bloc.dart';

abstract class OromoTranslationPageEvent extends Equatable{
  const OromoTranslationPageEvent();
}

class NavigateForward extends OromoTranslationPageEvent{
  @override
  List<Object?> get props => [];
}

class GetEnglishTranslationsList extends OromoTranslationPageEvent {
  final String oromoWord;

  ///Retrieves the Search Results for the oromoWord inputted.
  ///
  ///oromoWord: String
  GetEnglishTranslationsList(this.oromoWord);

  @override
  List<Object?> get props => [oromoWord];
}