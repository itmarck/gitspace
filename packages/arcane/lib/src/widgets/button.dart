import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'font.dart';
import 'surface.dart';

class Button extends StatefulWidget {
  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        setState(() {});
      });
    animation = ColorTween(
      begin: pink,
      end: pink.withOpacity(0.8),
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) {
        controller.forward();
      },
      onTapUp: (details) {
        controller.reverse();
      },
      onTapCancel: () {
        controller.reverse();
      },
      child: Surface(
        padding: const EdgeInsets.all(12.0),
        background: animation.value,
        child: Center(
          child: Font(widget.text, FontType.subtitle),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
