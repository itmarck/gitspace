import 'dart:io';

import 'package:http/http.dart';

import 'token.dart';

const _baseUrl = 'https://gitlab.com/api/v4';

class Manager {
  final Method method;
  final String path;
  final Map<String, dynamic>? body;

  String? _token;

  Manager({
    required this.method,
    required this.path,
    this.body,
  });

  Future<void> initialize() async {
    final manager = TokenManager();
    _token = await manager.getToken();
  }

  Uri get _uri {
    return Uri.parse('$_baseUrl$path');
  }

  Map<String, String> get _headers {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    if (_token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $_token';
    }

    return headers;
  }

  Future<Response> execute() async {
    await initialize();

    final response = await request();

    return Response(
      response.body,
      response.statusCode,
    );
  }

  Future<Response> request() async {
    switch (method) {
      case Method.get:
        return await get(_uri, headers: _headers);
      case Method.post:
        return await post(_uri, headers: _headers, body: body);
      case Method.put:
        return await put(_uri, headers: _headers, body: body);
      case Method.delete:
        return await delete(_uri, headers: _headers, body: body);
    }
  }
}

enum Method {
  get,
  post,
  put,
  delete,
}
