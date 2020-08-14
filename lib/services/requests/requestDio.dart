import 'dart:convert';

import 'package:personalflow/services/interfaces/RequestInterface.dart';

class RequestDio implements RequestInterface {
  @override
  Future post(String url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw UnimplementedError();
  }
}
