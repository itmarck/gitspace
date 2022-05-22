import 'dart:io';

import 'package:http/http.dart';

class HttpClient {
  final Client client;
  final String baseUrl;
  final Map<String, String> headers;

  HttpClient({
    required this.baseUrl,
    this.headers = const {},
  }) : client = Client();

  Future<Response> get(String resource) {
    return _sendUnstreamed('GET', resource);
  }

  Future<Response> post(String resource, {Object? body}) {
    return _sendUnstreamed('POST', resource, body);
  }

  Future<Response> put(String resource, {Object? body}) {
    return _sendUnstreamed('PUT', resource, body);
  }

  Future<Response> patch(String resource, {Object? body}) {
    return _sendUnstreamed('PATCH', resource, body);
  }

  Future<Response> delete(String resource, {Object? body}) {
    return _sendUnstreamed('DELETE', resource, body);
  }

  void addAuthorization(String token) {
    headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  Future<StreamedResponse> send(BaseRequest request) async {
    request.headers.addAll(headers);
    return client.send(request);
  }

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<Response> _sendUnstreamed(
    String method,
    String resource, [
    Object? body,
  ]) async {
    final url = Uri.parse('$baseUrl$resource');
    final request = Request(method, url);

    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is Map) {
        request.body = body.toString();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    return Response.fromStream(await send(request));
  }

  void close() {}
}
