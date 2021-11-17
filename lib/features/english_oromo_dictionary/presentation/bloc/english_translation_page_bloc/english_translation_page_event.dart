part of 'english_translation_page_bloc.dart';

abstract class EnglishTranslationPageEvent extends Equatable {
  const EnglishTranslationPageEvent();
}

class GetEnglishWordInfo extends EnglishTranslationPageEvent {
  final EnglishWord englishWord;

  ///Retrieves the corresponding english word info
  GetEnglishWordInfo(this.englishWord);

  @override
  List<Object?> get props => [englishWord];
}

class DisposeEnglishPage extends EnglishTranslationPageEvent{
  @override
  List<Object?> get props => [];
}
