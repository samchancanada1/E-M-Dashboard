import 'package:http/http.dart' as http;

/// A singleton HTTP client wrapper
class HttpClient {
  static final HttpClient _instance = HttpClient._internal();
  final http.Client _client = http.Client();

  factory HttpClient() {
    return _instance;
  }

  HttpClient._internal();

  http.Client get client => _client;

  void close() {
    _client.close();
  }
}
