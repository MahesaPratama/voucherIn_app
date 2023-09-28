import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {
  final String label;
  final TextStyle labelStyle;
  final double width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onTap;
  final Color buttonColor;
  const BoxButton({
    super.key,
    required this.label,
    required this.labelStyle,
    this.width = double.infinity,
    this.margin,
    this.padding,
    required this.onTap,
    this.buttonColor = const Color(0xff001c52),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        child: Text(
          label,
          style: labelStyle,
        ),
      ),
    );
  }
}
