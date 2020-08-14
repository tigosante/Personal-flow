import 'dart:convert';

abstract class RequestInterface {
  Future post(String url,
      {Map<String, String> headers, dynamic body, Encoding encoding});
}
