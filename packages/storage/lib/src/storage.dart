import 'package:types/document.dart';

abstract class Storage {
  Future<Document?> get(String key);
  Future<Documents> getAll(String key);
  Future<void> save(String key, Document value);
  Future<void> saveAll(String key, Documents value);
  Future<void> remove(String key);
}
