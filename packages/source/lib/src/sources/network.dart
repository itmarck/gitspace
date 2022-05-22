import 'package:domain/domain.dart';
import 'package:types/document.dart';

import '../client/client.dart';
import '../client/data.dart';
import '../source.dart';

abstract class NetworkSource implements Source {
  HttpClient get client;
  GitService get service;

  @override
  Future<Data<Document>> get(String resource) async {
    final response = await client.get(resource);
    return Data.from(response);
  }

  @override
  Future<Data<Documents>> getAll(String resource) async {
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
