import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const COLOR_BLACK = Colors.black;
const COLOR_WHITE = Colors.white;
const COLOR_GREY = Color(0xffededed);
const COLOR_YELLOW = Color(0xFFF4C002);
const COLOR_GREEN = Color(0xff02943F);
const COLOR_RED = Color(0xFFAF0200);

TextTheme defaultText = TextTheme(
    headline1: GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 96),
    headline2: GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 60),
    headline3: GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 48),
    headline4: GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 34),
    headline5: GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 24),
    headline6: GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 20),
    bodyText1: GoogleFonts.heebo(fontSize: 20, fontWeight: FontWeight.normal),
    bodyText2: GoogleFonts.heebo(
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    subtitle1: GoogleFonts.heebo(fontSize: 16, fontWeight: FontWeight.normal),
    subtitle2: GoogleFonts.heebo(fontSize: 14, fontWeight: FontWeight.w400),
    button: GoogleFonts.heebo(fontSize: 14, fontWeight: FontWeight.w400),
    caption: GoogleFonts.heebo(fontSize: 12, fontWeight: FontWeight.normal));
