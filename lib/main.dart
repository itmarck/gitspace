import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitspace/account.dart';
import 'package:gitspace/strings.dart';
import 'package:http/http.dart';

Future<String> fetchEmail(token) async {
  final uri = Uri.parse('https://api.github.com/user/public_emails');
  final response = await get(uri, headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final emails = jsonDecode(response.body) as List;
    final primaryEmail = emails.firstWhere((item) => item['primary'] == true);
    return primaryEmail['email'];
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
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.white24,
            fontWeight: FontWeight.normal,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC73966),
          onPrimary: Colors.white,
          background: Color(0xFF212429),
          surface: Color(0xFF26292E),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
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
  Account? account;

  void _onAccountChanged(Account account) {
    setState(() {
      this.account = account;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (account == null) {
      return AddAccountPage(onChange: _onAccountChanged);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 64.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'My accounts',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 32.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: AccountCard(account: account!),
        )
      ],
    );
  }
}

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.person,
            size: 32.0,
          ),
          const SizedBox(width: 24.0),
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
              fetchEmail(_textController.text).then((String email) {
                widget.onChange(Account(name: 'Github', email: email));
              });
            },
            child: const Text(Strings.signIn),
          ),
        )
      ],
    );
  }
}
