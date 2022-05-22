import 'package:flutter/widgets.dart';
import 'package:store/store.dart';

import 'pages/access_page.dart';
import 'pages/manager_page.dart';

class Delegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  late GlobalKey<NavigatorState> _navigatorKey;

  Delegate() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return Store(
      builder: (context, state, child) {
        return Navigator(
          key: _navigatorKey,
          pages: [
            if (state.accounts.isEmpty)
              const AccessPage()
            else
              const ManagerPage(),
          ],
          onPopPage: (Route route, result) {
            return false;
          },
        );
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
