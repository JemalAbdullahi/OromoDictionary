import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPResponse {
  final http.Client client;
  http.Response? response;

  HTTPResponse(this.client);

  Future<void> setResponseFrom(Uri uri) async {
    response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
  }

  Future<void> setResponseWithTimeoutFrom(Uri uri) async {
    response = await client
        .get(uri, headers: {'Content-Type': 'application/json'}).timeout(
            Duration(seconds: 5), onTimeout: () {
      return http.Response("Error", 500);
    });
  }

  bool isSuccessful() {
    return response!.statusCode == 200;
  }

  bool hasTimedOut() {
    return response!.statusCode == 500;
  }

  getResult() {
    return json.decode(response!.body);
  }
}
