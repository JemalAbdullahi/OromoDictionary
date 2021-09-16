import 'dart:io';

//Read json files as strings for testing purposes.
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
