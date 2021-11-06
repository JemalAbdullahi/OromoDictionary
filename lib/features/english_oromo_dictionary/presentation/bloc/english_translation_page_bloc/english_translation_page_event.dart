
part of 'english_translation_page_bloc.dart';

abstract class EnglishTranslationPageEvent extends Equatable {
  const EnglishTranslationPageEvent();
}

class GetGrammaticalForms extends EnglishTranslationPageEvent {
  final int wordID;

  ///Retrieves the corresponding grammatical forms
  GetGrammaticalForms(this.wordID);

  @override
  List<Object?> get props => [wordID];
}
