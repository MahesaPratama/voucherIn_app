import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TxtButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const TxtButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: onTap,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: const Color(0xffb3b5c4),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          )),
    );
  }
}
