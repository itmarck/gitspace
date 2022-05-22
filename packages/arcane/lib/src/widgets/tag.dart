import 'package:flutter/widgets.dart';

import '../theme/colors.dart';
import 'font.dart';

class Tag extends StatelessWidget {
  const Tag({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: gray3,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Font(text, FontType.caption),
      ),
    );
  }
}
