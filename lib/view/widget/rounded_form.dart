import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Perbaiki nilai onChanged dibawah ini
class RoundedForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool hideText;
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? icon;
  const RoundedForm({
    super.key,
    required this.label,
    required this.controller,
    this.hideText = false,
    this.onChanged,
    this.hintText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xffB3B4C4),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: hideText,
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: 12,
              ),
              fillColor: const Color(0xfff1f0f5),
              filled: true,
              suffixIcon: icon,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff4141a4)),
                borderRadius: BorderRadius.circular(100),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(100),
              )),
        ),
      ],
    );
  }
}
