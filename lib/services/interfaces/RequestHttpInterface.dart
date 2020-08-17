import 'package:http/http.dart';

abstract class RequestHttpInterface {
  Future<Response> get(String url, {Map<String, String> headers});
}
