import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oromo_dictionary/src/screens/search_screen.dart';
import 'package:oromo_dictionary/src/screens/translation_screen.dart';
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
        ),
        home: ChangeNotifierProvider(
          create: (context) => EnglishWordListViewModel(),
          child: SearchScreen(),
        ),
        routes: <String, WidgetBuilder>{
          SearchScreen.routeName: (BuildContext context) => SearchScreen(),
          TranslationScreen.routeName: (BuildContext context) =>
              TranslationScreen(),
        });
  }
}
