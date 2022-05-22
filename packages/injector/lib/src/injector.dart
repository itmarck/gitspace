import 'box.dart';

class Injector {
  Injector._internal();

  final List<Box> _boxes = [];

  void register<T>(Box box) {
    _boxes.add(box);
  }

  static Box get box {
    if (instance._boxes.isEmpty) {
      throw Exception('No boxes registered');
    }

    return instance._boxes.last;
  }

  static final Injector instance = Injector._internal();
}
