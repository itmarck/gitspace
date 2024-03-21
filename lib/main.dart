import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitspace/account.dart';
import 'package:gitspace/screens/home_screen.dart';
import 'package:gitspace/store.dart';
import 'package:gitspace/strings.dart';
import 'package:gitspace/theme.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Account> fetchAccount(token) async {
  final uri = Uri.parse('https://api.github.com/user/public_emails');
  final response = await get(uri, headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final emails = jsonDecode(response.body) as List;
    final primaryEmail = emails.firstWhere((item) => item['primary'] == true);
    return Account(
      name: 'Github',
      email: primaryEmail['email'],
      token: token,
    );
  } else {
    throw Exception('Failed to fetch email');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider<Store>(
      create: (context) => Store(preferences: preferences),
      child: const Gitspace(),
    ),
  );
}

class Gitspace extends StatelessWidget {
  const Gitspace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      home: const Scaffold(
        body: SafeArea(
          child: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context, listen: false);
    final accounts = Provider.of<Store>(context).accounts;
    final activeAccount = Provider.of<Store>(context).activeAccount;

    if (accounts.isEmpty) {
      return AddAccountPage(onChange: store.add);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 64.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            Strings.accountsPageTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 32.0),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: 16.0,
              children: [
                for (var account in accounts)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: AccountCard(
                      account: account,
                      onTap: (Account account) {
                        store.select(account);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      onLongPress: store.remove,
                      selected: identical(account, activeAccount),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      Strings.removeAccountHint,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy < 0) {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: AddAccountPage(onChange: (Account account) {
                      store.add(account);
                      Navigator.pop(context);
                    }),
                  );
                },
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: const Column(
              children: [
                Text(Strings.addAccountHint),
                Icon(Icons.keyboard_arrow_up_rounded, size: 48.0),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}

class Confirmation extends StatelessWidget {
  final String title;
  final String description;
  final String okText;
  final String cancelText;
  final void Function()? onOk;

  const Confirmation({
    super.key,
    required this.title,
    required this.description,
    required this.okText,
    this.onOk,
    cancelText,
  }) : cancelText = cancelText ?? 'Cancel';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onOk,
          child: Text(okText),
        )
      ],
    );
  }
}

class AccountCard extends StatelessWidget {
  final Account account;
  final void Function(Account) onTap;
  final void Function(Account) onLongPress;
  final bool selected;

  const AccountCard({
    super.key,
    required this.account,
    required this.onTap,
    required this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(account);
      },
      onLongPress: () {
        if (selected) return;

        showDialog(
          context: context,
          builder: (context) {
            return Confirmation(
              title: 'Are you sure?',
              description: 'This action cannot be undone',
              okText: 'Yes',
              onOk: () {
                onLongPress(account);
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.surface : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              size: 32.0,
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(account.email),
                Text(
                  account.name,
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddAccountPage extends StatefulWidget {
  final void Function(Account) onChange;

  const AddAccountPage({super.key, required this.onChange});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 64.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            Strings.addAccountPageTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 16.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(Strings.addAccountPageDescription),
        ),
        const SizedBox(height: 64.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            Strings.personalAccessToken,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                hintText: Strings.personalAccessTokenHint,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: FilledButton(
            onPressed: () {
              fetchAccount(_textController.text).then((Account account) {
                widget.onChange(account);
              });
            },
            child: const Text(Strings.signIn),
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
