import 'package:flutter/widgets.dart';
import 'package:gitspace/account.dart';

class Store extends ChangeNotifier {
  final List<Account> _accounts = [];
  Account? _active;

  Store() {
    // Debug purpose only. Remove it once it's done.
    _accounts.addAll([
      Account(
        email: 'me@example.com',
        name: 'Github',
        token: 'token',
      ),
      Account(
        email: 'test@gmail.com',
        name: 'Gitlab',
        token: 'token',
      ),
    ]);
  }

  /// List of all accounts in the user device.
  List<Account> get accounts => List.unmodifiable(_accounts);

  /// Currently active account. There should be always an active account.
  Account? get activeAccount {
    if (_accounts.isEmpty) {
      return null;
    }

    if (_active == null) {
      return _accounts.first;
    }

    return _active;
  }

  void select(Account account) {
    _active = account;
    notifyListeners();
  }

  void add(Account account) {
    _accounts.add(account);
    notifyListeners();
  }

  void remove(Account account) {
    _accounts.remove(account);
    notifyListeners();
  }
}
