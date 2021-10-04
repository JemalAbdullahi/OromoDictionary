import 'dart:io';

//Read json files as strings for testing purposes.
String fixture(String folder, String name) => File('test/fixtures/$folder/$name').readAsStringSync();
