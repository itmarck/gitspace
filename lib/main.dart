import 'package:flutter/material.dart';
import 'package:gitspace/strings.dart';

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
          child: AddAccountPage(),
        ),
      ),
    );
  }
}

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 64.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Add an account',
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
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                hintText: Strings.personalAccessTokenHint,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: FilledButton(
            onPressed: () => {},
            child: const Text(Strings.signIn),
          ),
        )
      ],
    );
  }
}
