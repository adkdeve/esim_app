import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/smooth_rectangle_border.dart';

import '../../app/core/resources/r.dart';

class Textedit2 extends StatelessWidget {
  const Textedit2({
    super.key,
    required this.title,
    this.hintText = '',
    this.hintTextColor = Colors.grey,
    this.titleTextColor = Colors.black,
    this.icon = '',
    this.maxLines = 1,
    this.minLines = 1,
    this.borderRadius = 12.0,
    this.require = false,
    this.text = '',
    this.titleFontSize = 14,
    this.textFontSize = 16,
  });
  final String title;
  final String hintText;
  final Color hintTextColor;
  final Color titleTextColor;
  final String icon;
  final String text;
  final int maxLines;
  final double borderRadius;
  final double titleFontSize;
  final double textFontSize;
  final int minLines;
  final bool require;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          maxLines: 3,
          TextSpan(
            children: [
              TextSpan(
                text: title,
                style: GoogleFonts.inter().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize,
                  letterSpacing: 0.3,
                  // color: titleTextColor,
                ),
              ),
              TextSpan(
                text: require ? '*' : '',
                style: GoogleFonts.inter().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize,
                  letterSpacing: 0.3,
                  color: R.theme.red,
                ),
              ),
            ],
          ),
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: MyText(
        //         textAlign: TextAlign.left,
        //         text: title,
        //         fontSize: 16,
        //         color: blackColor,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     Visibility(
        //       visible: require,
        //       child: const MyText(
        //         text: '*',
        //         fontSize: 16,
        //         color: red,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   ],
        // ),
        15.sbh,
        Container(
          padding: const EdgeInsets.all(2),
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              side: BorderSide(color: R.theme.color200),
            ),
          ),
          child: TextFormField(
            controller: TextEditingController(text: text),
            cursorColor: R.theme.primary,
            maxLines: maxLines,
            readOnly: icon != '',
            minLines: minLines,
            style: GoogleFonts.inter().copyWith(
              // color: primaryColor,
              fontSize: textFontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConfig.defaultPadding,
                vertical: 12,
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.inter().copyWith(
                color: hintTextColor,
                fontSize: 14,
                fontWeight: hintTextColor == R.theme.black
                    ? FontWeight.w600
                    : FontWeight.w400,
                letterSpacing: 0.3,
              ),
              suffixIcon: icon == ''
                  ? null
                  : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConfig.defaultPadding,
                ),
                child: SvgPicture.asset(icon),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
