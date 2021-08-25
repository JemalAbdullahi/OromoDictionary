import 'package:flutter/material.dart';
import 'package:oromo_dictionary/src/utils/constants.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

AppBar customAppBar() {
  return AppBar(
    automaticallyImplyLeading: true,
    iconTheme: IconThemeData(color: COLOR_YELLOW),
    elevation: 0,
  );
}

Container oddaaImage() {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: COLOR_YELLOW,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
        padding: EdgeInsets.all(8),
        child: Image.asset("assets/images/Oddaa.png")),
  );
}
