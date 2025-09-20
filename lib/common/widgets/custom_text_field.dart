import 'package:flutter/material.dart';
import 'package:pcom_app/app/core/core.dart';
import 'my_text.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Color borderClr;
  final TextEditingController controller;
  final bool obscureText;

  CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.borderClr = Colors.grey,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        8.sbh,
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: R.theme.transparent,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: 8.radius,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: 8.radius,
              borderSide: BorderSide(color: borderClr),
            ),
          ),
        ),
      ],
    );
  }
}
