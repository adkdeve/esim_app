import 'package:flutter/material.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/build_image.dart';

import 'my_text.dart';

class SocialButton extends StatelessWidget {
  final dynamic icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 6.vertical,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: buildImage(icon, width: 24),
        label: MyText(text: text, color: textColor, fontSize: 16),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor ?? backgroundColor),
          padding: 14.vertical,
          shape: RoundedRectangleBorder(
            borderRadius: 12.radius,
          ),
        ),
      ),
    );
  }
}
