import 'package:types/document.dart';

import 'client/data.dart';

abstract class Source {
  Future<Data<Document>> get(String resource);
  Future<Data<Documents>> getAll(String resource);
  Future<Data<Document>> post(String resource, {Object? body});
}
