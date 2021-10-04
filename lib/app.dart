import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'core/presentation/util/constants.dart';
import 'features/english_oromo_dictionary/presentation/pages/search_page.dart';
import 'features/english_oromo_dictionary/presentation/pages/oromo_alphabet_page.dart';

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
          iconTheme: IconThemeData(color: COLOR_YELLOW, size: 32.0),
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              backgroundColor: Theme.of(context).primaryColor,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              defaultName: MOBILE,
              breakpoints: [
                ResponsiveBreakpoint.autoScale(480, name: MOBILE),
                ResponsiveBreakpoint.resize(600, name: MOBILE),
                ResponsiveBreakpoint.resize(850, name: TABLET),
                ResponsiveBreakpoint.resize(1080, name: DESKTOP),
              ],
            ),
        home: SearchPage(),
        routes: <String, WidgetBuilder>{
          SearchPage.routeName: (BuildContext context) => SearchPage(),
          OromoAlphabetPage.routeName: (BuildContext context) =>
              OromoAlphabetPage(),
          //    EnglishOromoTranslationScreen.routeName: (BuildContext context) =>
          //        EnglishOromoTranslationScreen(),
          // OromoEnglishTranslationScreen.routeName: (BuildContext context) =>
          // ChangeNotifierProvider(
          // create: (context) => SearchListViewModel(),
          // child: OromoEnglishTranslationScreen()),
        });
  }
}
