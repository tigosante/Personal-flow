import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:personal_flow/services/interfaces/RequestHttpInterface.dart';

class RequestHttp implements RequestHttpInterface {
  Future<Response> get(String url, {Map<String, String> headers}) async =>
      await http.get(url, headers: headers);
}
