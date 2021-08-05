import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oromo_dictionary/screens/search_screen.dart';
import 'package:oromo_dictionary/screens/translation_screen.dart';
import 'package:oromo_dictionary/utils/constants.dart';
import 'package:oromo_dictionary/viewmodels/english_view_models/english_word_list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

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

class HomePage extends StatefulWidget {
  //static const String routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double height = size.height * 0.08;
    final double width = size.width * 0.9;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: COLOR_RED,
        body: Stack(children: <Widget>[
          Positioned(
              top: size.height / 4,
              child: Container(
                width: size.width,
                child: Center(
                  child: Text(
                    "English-Oromo Dictionary",
                    style: textTheme.headline3!.apply(color: COLOR_YELLOW),
                  ),
                ),
              )),
          Center(
            child: Container(
              height: height,
              width: width,
              padding: EdgeInsets.only(left: 12, top: 3),
              decoration: BoxDecoration(
                color: COLOR_YELLOW,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10.0,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                style: textTheme.bodyText1!.apply(color: COLOR_RED),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class HomePageTwo extends StatefulWidget {
  static const String routeName = "/";
  const HomePageTwo({Key? key}) : super(key: key);

  @override
  _HomePageTwoState createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double totalHeight = size.height;
    //double totalWidth = size.width;
    final double height = totalHeight * 0.2;
    final double tfHeight = size.height * 0.05;
    final double tfWidth = size.width * 0.8;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: COLOR_GREY,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "English-Oromo Dictionary",
            style: textTheme.headline5!.apply(color: COLOR_YELLOW),
          ),
          backgroundColor: COLOR_RED,
          leading: Icon(
            Icons.menu,
            color: COLOR_YELLOW,
          ),
        ),
        body: Container(
          height: height,
          width: double.infinity,
          decoration: new BoxDecoration(
            color: COLOR_RED,
            // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
            boxShadow: [
              new BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 25.0,
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Container(
              height: tfHeight,
              width: tfWidth,
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10.0,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: COLOR_RED),
                  border: InputBorder.none,
                  hintText: "Search a word...",
                  //contentPadding: EdgeInsets.only(bottom: 12),
                ),
                style: textTheme.bodyText1!.apply(color: COLOR_RED),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
