import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.gradient, this.style});

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) => ShaderMask(blendMode: BlendMode.srcIn, shaderCallback: (Rect bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)), child: Text(text, style: style));
}
