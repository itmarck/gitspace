import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'state.dart';
import 'wrapper.dart';

typedef StoreBuilder = Widget Function(
  BuildContext,
  ApplicationState,
  Widget?,
);

class Store extends StatelessWidget {
  const Store({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final StoreBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, state, child) {
        return builder(context, state, child);
      },
      child: child,
    );
  }

  static Widget wrapper({required Widget child}) {
    return StoreWrapper(
      child: child,
    );
  }

  static ApplicationState of(BuildContext context) {
    return Provider.of<ApplicationState>(context, listen: false);
  }
}
