import 'package:bloc/bloc.dart';
import '../../../domain/entities/grammatical_form.dart';
import '../../../domain/usecases/english_word_page/get_grammatical_form_list.dart';

import '../bloc_imports.dart';
import '../page_states.dart';
part 'english_translation_page_event.dart';
part 'english_translation_page_state.dart';

class EnglishTranslationPageBloc
    extends Bloc<EnglishTranslationPageEvent, PageState> {
  GetGrammaticalFormList getGrammaticalFormList;

  EnglishTranslationPageBloc({required this.getGrammaticalFormList})
      : super(Empty()) {
    on<GetGrammaticalForms>(_onGetGrammaticalForms);
  }

  _onGetGrammaticalForms(
      GetGrammaticalForms event, Emitter<PageState> emit) async {
    emit(Empty());

    emit(Loading());
    final failureOrGrammaticalForms =
        await getGrammaticalFormList(Params(wordID: event.wordID));
    emit(failureOrGrammaticalForms.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (grammaticalForms) => Loaded(grammaticalForms: grammaticalForms)));
  }
}
