import 'service.dart';
import 'user.dart';

class Account {
  final GitService service;
  final String token;
  final User user;

  Account({
    required this.service,
    required this.token,
    required this.user,
  });
}
