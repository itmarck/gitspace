import 'token.dart';

Future<void> setupToken(String token) async {
  final manager = TokenManager();
  await manager.saveToken(token);
}
