import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gitspace/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store extends ChangeNotifier {
  final SharedPreferences _preferences;
  List<Account> _accounts = [];
  Account? _active;

  Store({required SharedPreferences preferences}) : _preferences = preferences {
    _accounts = _load(preferences);
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
    _save(_accounts, _preferences);
    notifyListeners();
  }

  void remove(Account account) {
    _accounts.remove(account);
    _save(_accounts, _preferences);
    notifyListeners();
  }
}

void _save(List<Account> accounts, SharedPreferences preferences) {
  final encodedAccounts = jsonEncode(
    accounts.map((account) => account.toMap()).toList(),
  );
  preferences.setString('accounts', encodedAccounts);
}

List<Account> _load(SharedPreferences preferences) {
  final encodedAccounts = preferences.getString('accounts');

  if (encodedAccounts == null) {
    return [];
  }

  return (jsonDecode(encodedAccounts) as List).map((item) {
    return Account.fromMap(item);
  }).toList();
}
