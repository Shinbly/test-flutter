import "dart:convert";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;

///this is the abstract class for all http services
///this is used to make the code more readable
///and to make it easier to change the http package in the future
abstract class HttpService {
  ///this is the get method that is used to make a get request
  ///it takes a url and an optional client and headers
  ///the optionnal client is used to make mockups in the tests
  ///
  ///it returns a Future of a Map of String and dynamic representing the body as json
  ///if the request is successful
  ///
  ///it throws an exception if the request is not successful
  static Future<Map<String, dynamic>> get(
    Uri url, {
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    client ??= http.Client();
    final http.Response res = await client.get(url, headers: headers);
    if (kDebugMode) {
      print(
          "[HTTP] : ${res.request?.method} ${res.request?.url.host}/${res.request?.url.port} ${res.request?.url.path} [${res.statusCode}]");
      print(res.body);
    }
    if (res.statusCode != 200) {
      throw HttpException(
        "error while fetching the data statusCode : [${res.statusCode}] : ${res.body}",
        uri: url,
      );
    }
    final Map<String, dynamic> json = jsonDecode(res.body);
    return json;
  }
}
