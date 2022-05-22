import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'font.dart';
import 'surface.dart';

class Input extends StatefulWidget {
  const Input.text({
    Key? key,
    required this.label,
    this.placeholder,
    this.controller,
  }) : super(key: key);

  final String label;
  final String? placeholder;
  final TextEditingController? controller;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  void initState() {
    super.initState();
  }

  Widget get label {
    return Font(widget.label, FontType.label);
  }

  Widget get wrapper {
    return Surface(
      padding: EdgeInsets.all(0.0),
      style: SurfaceStyle.inside,
      child: input,
    );
  }

  Widget get input {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.placeholder,
        hintStyle: TextStyle(color: gray3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
      ),
      cursorColor: gray2,
      style: TextStyle(
        color: gray1,
        fontSize: 14.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        const SizedBox(height: 12.0),
        wrapper,
        const SizedBox(height: 12.0),
      ],
    );
  }
}
