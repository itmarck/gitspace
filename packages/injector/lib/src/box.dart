import 'package:infrastructure/infrastructure.dart';
import 'package:repositories/account.dart';
import 'package:storage/local.dart';
import 'package:store/store.dart';

class Box {
  final ApplicationState state;

  Box({
    required this.state,
  });

  AccountRepository get accountRepository {
    return LocalAccountRepository(
      sources: [
        GitlabSource(),
        GithubSource(),
      ],
      storage: SecureStorage(),
    );
  }
}
