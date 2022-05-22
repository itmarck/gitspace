import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'client.dart';

typedef Document = Map<String, dynamic>;
typedef Documents = List<Document>;

class Data<T> {
  late int code;
  late T body;

  Data({
    required this.code,
    required this.body,
  });

  factory Data.from(Response response) {
    final body = json.decode(response.body);

    return Data(
      code: response.statusCode,
      body: body as T,
    );
  }
}

abstract class Source {
  Future<Data<Document>> get(String resource);
  Future<Data<Documents>> getAll(String resource);
  Future<Data<Document>> post(String resource, {Object? body});
}

abstract class NetworkSource implements Source {
  HttpClient get client;

  @override
  Future<Data<Document>> get(String resource) async {
    final response = await client.get(resource);
    return Data.from(response);
  }

  @override
  Future<Data<List<Document>>> getAll(String resource) async {
    final response = await client.get(resource);
    return Data.from(response);
  }

  @override
  Future<Data<Document>> post(String resource, {Object? body}) async {
    final response = await client.post(resource, body: body);
    return Data.from(response);
  }

  void addAuthorization(String token) {
    client.addAuthorization(token);
  }
}

class GitlabSource extends NetworkSource {
  @override
  final HttpClient client = HttpClient(
    baseUrl: 'https://gitlab.com/api/v4',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
}

class GithubSource extends NetworkSource {
  @override
  final HttpClient client = HttpClient(
    baseUrl: 'https://api.github.com',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
}
