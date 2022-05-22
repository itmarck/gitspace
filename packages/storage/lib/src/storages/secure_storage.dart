import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:types/document.dart';

import '../storage.dart';

class SecureStorage extends Storage {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Future<Document?> get(String key) async {
    final value = await storage.read(key: key);

    if (value == null) {
      return null;
    }

    return json.decode(value) as Document;
  }

  @override
  Future<Documents> getAll(String key) async {
    final value = await storage.read(key: key);

    if (value == null) {
      return [];
    }

    return [
      for (final item in json.decode(value) as List) item as Document,
    ];
  }

  @override
  Future<void> save(String key, Document value) async {
    await storage.write(
      key: key,
      value: json.encode(value),
    );
  }

  @override
  Future<void> saveAll(String key, Documents value) async {
    await storage.write(
      key: key,
      value: json.encode(value),
    );
  }

  @override
  Future<void> remove(String key) async {
    await storage.delete(key: key);
  }
}
