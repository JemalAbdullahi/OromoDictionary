import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oromo_dictionary/src/screens/oromo_alphabet_screen.dart';
import 'package:oromo_dictionary/src/screens/search_screen.dart';
import 'package:oromo_dictionary/src/screens/translation_screens/english_oromo_translation_screen.dart';
import 'package:oromo_dictionary/src/screens/translation_screens/oromo_english_translation_screen.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';
import 'package:oromo_dictionary/src/viewmodels/english_view_models/english_word_list_view_model.dart';
import 'package:provider/provider.dart';

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
        home: ChangeNotifierProvider(
          create: (context) => SearchListViewModel(),
          child: SearchScreen(),
        ),
        routes: <String, WidgetBuilder>{
          SearchScreen.routeName: (BuildContext context) => SearchScreen(),
          EnglishOromoTranslationScreen.routeName: (BuildContext context) =>
              EnglishOromoTranslationScreen(),
          OromoEnglishTranslationScreen.routeName: (BuildContext context) =>
              ChangeNotifierProvider(
                  create: (context) => SearchListViewModel(),
                  child: OromoEnglishTranslationScreen()),
          OromoAlphabetScreen.routeName: (BuildContext context) =>
              OromoAlphabetScreen(),
        });
  }
}
