import 'dart:convert';

import 'package:http/http.dart';

class Data<T> {
  late int code;
  late T body;

  Data({
    required this.code,
    required this.body,
  });

  factory Data.from(Response response) {
    final body = json.decode(
      utf8.decode(response.bodyBytes),
    );

    return Data(
      code: response.statusCode,
      body: body as T,
    );
  }
}
