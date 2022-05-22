import 'package:arcane/src/common/decoration.dart';
import 'package:arcane/src/theme/colors.dart';
import 'package:flutter/material.dart';

const _defaultPadding = EdgeInsets.symmetric(
  vertical: 12.0,
  horizontal: 20.0,
);

const graySoft = Color(0xFF111316);
const almostWhite = Color(0xFF313438);

enum SurfaceStyle {
  outside,
  inside,
}

class Surface extends StatefulWidget {
  const Surface({
    Key? key,
    required this.child,
    this.style = SurfaceStyle.outside,
    this.padding = _defaultPadding,
    this.value = 2.0,
    this.background,
  }) : super(key: key);

  final Widget child;
  final double value;
  final Color? background;
  final SurfaceStyle style;
  final EdgeInsetsGeometry padding;

  @override
  State<Surface> createState() => _SurfaceState();
}

class _SurfaceState extends State<Surface> {
  @override
  Widget build(BuildContext context) {
    switch (widget.style) {
      case SurfaceStyle.outside:
        return Container(
          decoration: outsideDecoration,
          padding: widget.padding,
          child: widget.child,
        );
      case SurfaceStyle.inside:
        return Container(
          decoration: insideDecoration,
          padding: widget.padding,
          child: widget.child,
        );
    }
  }

  Decoration get outsideDecoration {
    return BoxDecoration(
      color: widget.background ?? dark1,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: graySoft,
          offset: Offset(widget.value, widget.value),
          blurRadius: 4.0,
        ),
        BoxShadow(
          color: almostWhite,
          offset: Offset(-widget.value, -widget.value),
          blurRadius: 4.0,
        ),
      ],
    );
  }

  Decoration get insideDecoration {
    return ConcaveDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      colors: [graySoft, almostWhite],
      depth: -widget.value * 2,
    );
  }
}
