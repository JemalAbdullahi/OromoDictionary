import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oromo_dictionary/features/english_oromo_dictionary/presentation/bloc/english_translation_page_bloc/english_translation_page_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'core/presentation/util/constants.dart';
import 'features/english_oromo_dictionary/presentation/bloc/oromo_translation_page_bloc/oromo_translation_page_bloc.dart';
import 'features/english_oromo_dictionary/presentation/bloc/search_page_bloc/bloc.dart';
import 'features/english_oromo_dictionary/presentation/pages/english_to_oromo_translation_page.dart';
import 'features/english_oromo_dictionary/presentation/pages/oromo_alphabet_page.dart';
import 'features/english_oromo_dictionary/presentation/pages/oromo_to_english_translation_page.dart';
import 'features/english_oromo_dictionary/presentation/pages/search_page.dart';
import 'injection_container.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SearchPageBloc _searchPageBloc = sl<SearchPageBloc>();
  final OromoTranslationPageBloc _oromoTranslationPageBloc =
      sl<OromoTranslationPageBloc>();
  final EnglishTranslationPageBloc _englishTranslationPageBloc =
      sl<EnglishTranslationPageBloc>();

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
        routes: <String, WidgetBuilder>{
          SearchPage.routeName: (context) => BlocProvider.value(
                value: _searchPageBloc,
                child: SearchPage(),
              ),
          OromoAlphabetPage.routeName: (context) => OromoAlphabetPage(),
          OromoToEnglishTranslationPage.routeName: (context) =>
              BlocProvider.value(
                value: _oromoTranslationPageBloc,
                child: OromoToEnglishTranslationPage(),
              ),
          EnglishToOromoTranslationPage.routeName: (BuildContext context) =>
              BlocProvider.value(
                value: _englishTranslationPageBloc,
                child: EnglishToOromoTranslationPage(),
              ),
          // OromoEnglishTranslationScreen.routeName: (BuildContext context) =>
          // ChangeNotifierProvider(
          // create: (context) => SearchListViewModel(),
          // child: OromoEnglishTranslationScreen()),
        });
  }

  @override
  void dispose() {
    _searchPageBloc.close();
    super.dispose();
  }
}
