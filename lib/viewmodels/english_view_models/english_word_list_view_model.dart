import 'package:flutter/cupertino.dart';
import 'package:oromo_dictionary/services/search_service.dart';
import 'package:oromo_dictionary/viewmodels/english_view_models/english_word_view_model.dart';

class EnglishWordListViewModel extends ChangeNotifier {
  List<EnglishWordViewModel> englishWords = [];

  Future<void> fetchEnglishWords(String keyword) async {
    final results = await SearchService().fetchEnglishWords(keyword);
    this.englishWords =
        results.map((item) => EnglishWordViewModel(item)).toList();
    notifyListeners();
  }
}
