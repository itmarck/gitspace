import 'package:arcane/arcane.dart';
import 'package:flutter/widgets.dart';
import 'package:store/store.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Store(
      builder: (context, state, child) {
        if (state.accounts.isEmpty) {
          return child!;
        }

        return ListView.builder(
          itemCount: state.accounts.length,
          itemBuilder: (context, index) {
            final account = state.accounts[index];
            final name = account.user.name;
            final service = account.service.name;
            return Surface(
              child: Font('[$service] $name'),
            );
          },
        );
      },
      child: const Font('There is no accounts yet.'),
    );
  }
}
