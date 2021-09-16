import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'english_oromo_dictionary_event.dart';
part 'english_oromo_dictionary_state.dart';
class EnglishOromoDictionaryBloc extends Bloc<EnglishOromoDictionaryEvent, EnglishOromoDictionaryState> {
  EnglishOromoDictionaryBloc() : super(EnglishOromoDictionaryInitial());
  @override
  Stream<EnglishOromoDictionaryState> mapEventToState(
    EnglishOromoDictionaryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
