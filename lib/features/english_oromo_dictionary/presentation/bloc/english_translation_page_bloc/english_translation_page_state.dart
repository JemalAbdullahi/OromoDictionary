part of 'english_translation_page_bloc.dart';


class Loaded extends PageState {
  final List<GrammaticalForm> grammaticalForms;
  //phonetic string

  Loaded({required this.grammaticalForms});
  @override
  List<Object> get props => [grammaticalForms];
}
