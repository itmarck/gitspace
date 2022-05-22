import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';

mixin AccountStore on ChangeNotifier {
  List<Account> accounts = [];

  Future<void> loadAccounts() async {
    final repository = Injector.box.accountRepository;
    accounts = await repository.getAccounts();
    notifyListeners();
  }

  Future<void> addAccount(String token) async {
    final repository = Injector.box.accountRepository;
    final account = await repository.addAccount(token);

    if (account == null) {
      return;
    }

    accounts.add(account);
    notifyListeners();
  }
}
