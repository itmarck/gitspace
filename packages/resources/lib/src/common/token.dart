import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storageKey = 't0k3n';

class TokenManager {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await _storage.read(key: _storageKey);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _storageKey, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _storageKey);
  }
}
