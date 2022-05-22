import 'package:arcane/arcane.dart';
import 'package:flutter/material.dart';
import 'package:store/store.dart';

class AccessScreen extends StatelessWidget {
  AccessScreen({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32.0),
            const Font('Add an account', FontType.headline),
            const SizedBox(height: 24.0),
            const Font(
              'You can create a personal access token in your profile settings',
            ),
            const SizedBox(height: 64.0),
            Input.text(
              controller: controller,
              label: 'Personal access token',
              placeholder: 'GitLab or GitHub token',
            ),
            const SizedBox(height: 16.0),
            Button(
              text: 'Sign in',
              onPressed: () async {
                print('Adding account...');
                await Store.of(context).addAccount(controller.text);
                print('Account added!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
