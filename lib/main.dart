import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import 'app.dart';

void main() {
  di.init();
  runApp(MyApp());
}
