import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'english_oromo_dictionary_event.dart';
part 'english_oromo_dictionary_state.dart';
class EnglishOromoDictionaryBloc extends Bloc<EnglishOromoDictionaryEvent, EnglishOromoDictionaryState> {
  GetEnglishWordList getEnglishWordList;
  GetOromoWordList getOromoWordList;
  
  EnglishOromoDictionaryBloc({
    required GetEnglishWordList this.getEnglishWordList,
    required GetOromoWordList this.getOromoWordList,
  }) : super(Empty());

  @override
  Stream<EnglishOromoDictionaryState> mapEventToState(
    EnglishOromoDictionaryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
