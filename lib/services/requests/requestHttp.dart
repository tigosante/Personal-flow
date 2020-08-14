import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:personalflow/services/interfaces/RequestInterface.dart';

class RequestHttp implements RequestInterface {
  Future post(String url,
          {Map<String, String> headers, dynamic body, Encoding encoding}) =>
      http.post(url, headers: headers, body: body, encoding: encoding);
}
