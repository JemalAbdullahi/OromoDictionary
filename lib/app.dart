import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/presentation/util/constants.dart';

import 'features/english_oromo_dictionary/presentation/pages/english_oromo_dictionary_search_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: COLOR_GREEN));

    return MaterialApp(
      title: 'Oromo Dictionary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: defaultText,
        primaryColor: COLOR_GREEN,
        accentColor: COLOR_YELLOW,
        iconTheme: IconThemeData(color: COLOR_YELLOW),
      ),
      home: EnglishOromoDictionarySearchPage(),
    );
  }
}
