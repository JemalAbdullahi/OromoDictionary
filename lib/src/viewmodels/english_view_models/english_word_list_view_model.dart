import 'package:flutter/cupertino.dart';
import 'package:oromo_dictionary/src/services/api.dart';
import 'package:oromo_dictionary/src/services/search_service.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_view_model.dart';
import 'package:oromo_dictionary/src/viewmodels/oromo_translation_view_models/oromo_translation_view_model.dart';

class SearchListViewModel extends ChangeNotifier {
  List<dynamic> words = [];
  List<EnglishWordViewModel> englishWords = [];

  Future<void> fetchWords(String keyword) async {
    final results = await SearchService().fetchWords(keyword);
    this.words = API.isEnglish()
        ? results.map((item) => EnglishWordViewModel(item)).toList()
        : results.map((item) => OromoTranslationViewModel(item)).toList();
    notifyListeners();
  }

  Future<void> fetchEnglishWords(String oromoWord) async {
    final results = await SearchService().fetchEnglishWords(oromoWord);
    this.words = results.map((item) => EnglishWordViewModel(item)).toList();
    notifyListeners();
  }
}
