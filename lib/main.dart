import 'package:arcane/arcane.dart';
import 'package:flutter/material.dart';
import 'package:store/store.dart';

import 'router/delegate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Store.wrapper(
      child: Arcane(
        delegate: Delegate(),
      ),
    );
  }
}
