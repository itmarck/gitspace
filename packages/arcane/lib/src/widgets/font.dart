import 'package:arcane/src/theme/colors.dart';
import 'package:flutter/widgets.dart';

enum FontType {
  headline,
  body,
  label,
  placeholder,
  caption,
  subtitle,
}

class Font extends StatelessWidget {
  const Font(
    this.content, [
    this.type,
    Key? key,
  ]) : super(key: key);

  final String content;
  final FontType? type;

  @override
  Widget build(BuildContext context) {
    return Text(content, style: style);
  }

  TextStyle get style {
    switch (type ?? FontType.body) {
      case FontType.headline:
        return TextStyle(
          color: white,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        );
      case FontType.subtitle:
        return TextStyle(
          color: white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        );
      case FontType.label:
        return TextStyle(
          color: gray1,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        );
      case FontType.body:
        return TextStyle(
          color: gray1,
          fontSize: 14.0,
        );
      case FontType.placeholder:
        return TextStyle(
          color: gray3,
          fontSize: 14.0,
        );
      case FontType.caption:
        return TextStyle(
          color: gray3,
          fontSize: 12.0,
        );
    }
  }
}
