import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const COLOR_BLACK = Colors.black;
const COLOR_WHITE = Colors.white;
const COLOR_GREY = Color(0xffededed);
const COLOR_YELLOW = Color(0xFFF4C002);
const COLOR_GREEN = Color(0xff02943F);
const COLOR_RED = Color(0xFFAF0200);

final TextTheme defaultText = TextTheme(
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

final Map<String, String> consonants = {
  'b': 'unstressed b as in body, about',
  'c': 'hard, glottalized tch sound',
  'd': 'stressed d sound as in dad',
  'f': 'unstressed f as in five or after',
  'g': 'unstressed g as in game or ago',
  'h': 'unstressed h as in hammer',
  'j': 'unstressed j as in jump or agency',
  'k': 'unstressed k as in coco',
  'l': 'unstressed l as in little',
  'm': 'unstressed m as in member',
  'n': 'unstressed n as in no',
  'p': 'unstressed p sound as in paper',
  'q': 'hard, glottalized k',
  'r': 'slightly rolling, soft r as in sparrow',
  's': 'unstressed s sound as in Susan',
  't': 'unstressed t as in tape',
  'v': 'unstressed v as in avenue or very',
  'w': 'unstressed, soft w sound as in now or wind',
  'x': 'hard, glottalized t',
  'y': 'unstressed y as in year or bayou',
  'z': 'unstressed z as in zigzag',
};
final Map<String, String> uniqueConsonants = {
  'ch': 'slightly stressed ch as in chase',
  'dh': 'glottalized d produced with the tongue curled back',
  'ph': 'glottalized p as in pope (said without breathing)',
  'sh': 'unstressed sh sound as in should',
  'ny': 'like the Spanish ñ, like onion or cognac',
};
final Map<String, String> shortVowels = {
  'a': 'short ah sound as in again or what',
  'e': 'e sound as in pen or empty',
  'i': 'short i as in hit or in',
  'o': 'o sound as in sore or open',
  'u': 'oo sound as in who or Spanish uno',
};
final Map<String, String> longVowels = {
  'aa': 'as in father, water, army',
  'aw': 'as in cow or ouch',
  'ay': 'as in aisle or pie',
  'ee': 'as in eight or gray',
  'ii': 'as in evil or teepee',
  'oo': 'long o as in oboe or sober',
  'oy': 'as in boy',
  'uu': 'long oo as in fool or spoon',
};
