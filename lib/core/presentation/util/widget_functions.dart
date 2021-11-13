import 'package:flutter/material.dart';

import 'constants.dart';

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
    decoration: _boxDecorationForOddaaImageContainer(),
    child: _oddaaImageAsset(),
  );
}

BoxDecoration _boxDecorationForOddaaImageContainer() {
  return BoxDecoration(
    color: COLOR_YELLOW,
    borderRadius: BorderRadius.circular(30),
  );
}

Padding _oddaaImageAsset() {
  return Padding(
      padding: EdgeInsets.all(8),
      child: Image.asset("assets/images/Oddaa.png"));
}
