import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({required this.heightDenominator,Key? key}) : super(key: key);

  final int heightDenominator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / heightDenominator,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
