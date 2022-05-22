import 'package:types/document.dart';

abstract class Mapper<T> {
  T from(Document document);
  Document to(T object);

  List<T> fromList(Documents documents) {
    return [for (final item in documents) from(item)];
  }

  Documents toList(List<T> objects) {
    return [for (final item in objects) to(item)];
  }
}
