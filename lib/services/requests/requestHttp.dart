import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:personal_flow/services/interfaces/RequestHttpInterface.dart';

class RequestHttp implements RequestHttpInterface {
  @override
  post(String url,
          {Map<String, String> headers, dynamic body, Encoding encoding}) =>
      http
          .post(url, headers: headers, body: body, encoding: encoding)
          .then((value) => print(value.body.toString()));
}
