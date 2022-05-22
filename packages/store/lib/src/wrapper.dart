import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

import 'state.dart';

class StoreWrapper extends StatefulWidget {
  const StoreWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<StoreWrapper> createState() => _StoreWrapperState();
}

class _StoreWrapperState extends State<StoreWrapper> {
  late ApplicationState state;

  _StoreWrapperState() {
    state = ApplicationState();

    Injector.instance.register(
      Box(state: state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApplicationState>.value(
          value: state,
        ),
      ],
      child: widget.child,
    );
  }
}
