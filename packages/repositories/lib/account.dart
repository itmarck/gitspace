import 'package:domain/domain.dart';
import 'package:mapper/user.dart';
import 'package:source/source.dart';
import 'package:storage/storage.dart';

abstract class AccountRepository {
  Future<List<Account>> getAccounts();
  Future<Account?> addAccount(String token);
}

class LocalAccountRepository implements AccountRepository {
  final List<NetworkSource> sources;
  final Storage storage;

  LocalAccountRepository({
    required this.sources,
    required this.storage,
  });

  @override
  Future<Account?> addAccount(String token) async {
    for (final source in sources) {
      source.addAuthorization(token);
      final data = await source.get('/user');

      if (data.code != 200) {
        continue;
      }

      final service = source.service;
      final isGitlab = service == GitService.gitlab;
      final mapper = isGitlab ? GitlabUserMapper() : GithubUserMapper();
      final account = Account(
        service: service,
        token: token,
        user: mapper.from(data.body),
      );

      final accounts = await getAccounts();
      accounts.add(account);
      storage.saveAll('accounts', [
        for (final item in accounts)
          {
            'service': item.service.name,
            'token': item.token,
            'user': mapper.to(item.user),
          }
      ]);

      return account;
    }

    return null;
  }

  @override
  Future<List<Account>> getAccounts() async {
    final accounts = await storage.getAll('accounts');
    return [
      for (final account in accounts)
        Account(
          service: account['service'] == GitService.gitlab.name
              ? GitService.gitlab
              : GitService.github,
          token: account['token'],
          user: account['service'] == GitService.gitlab.name
              ? GitlabUserMapper().from(account['user'])
              : GithubUserMapper().from(account['user']),
        ),
    ];
  }
}
