import 'package:flutter/material.dart';
import 'package:voucherin/view/Theme/style.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const RoundedButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: royalBlue,
          fixedSize: const Size(400, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(66),
          )),
      onPressed: onTap,
      child: Text(
        label,
        style: whiteTextStyle.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
