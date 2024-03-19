import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitspace/account.dart';
import 'package:gitspace/strings.dart';
import 'package:http/http.dart';

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

void main() {
  runApp(const Gitspace());
}

class Gitspace extends StatelessWidget {
  const Gitspace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        hintColor: Colors.white24,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Color(0xFFC73966),
          onPrimary: Colors.white,
          background: Color(0xFF212429),
          onBackground: Colors.white,
          surface: Color(0xFF1C1E22),
          surfaceTint: Colors.transparent,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white24),
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFF212429),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.white24,
            fontWeight: FontWeight.normal,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ),
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
  List<Account> accounts = [
    Account(email: 'me@example.com', name: 'Gitlab', token: 'token'),
    Account(email: 'marcelo@gmail.com', name: 'Github', token: 'token'),
  ];

  void _addAccount(Account account) {
    setState(() => accounts.add(account));
  }

  void _removeAccount(Account account) {
    setState(() => accounts.remove(account));
  }

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return AddAccountPage(onChange: _addAccount);
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
                      onLongPress: _removeAccount,
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
                      _addAccount(account);
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
  final void Function(Account) onLongPress;

  const AccountCard({
    super.key,
    required this.account,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
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
          color: Theme.of(context).colorScheme.surface,
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
