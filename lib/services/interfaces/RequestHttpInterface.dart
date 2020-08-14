import 'dart:convert';

abstract class RequestHttpInterface {
  post(String url,
      {Map<String, String> headers, dynamic body, Encoding encoding});
}
