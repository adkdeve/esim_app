import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../app/core/core.dart';
import 'my_text.dart';

class CustomGuide extends StatelessWidget {
  final String numberText;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;


  const CustomGuide({super.key,
    required this.numberText,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              color: R.theme.backgroundClr,
              borderRadius: 15.radius,
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA7B6DF),
                    Color(0xFF080F21),
                    Color(0xFF080F21),
                    Color(0xFF96A2C8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                width: 2,
              ),
            ),
            padding: 10.all,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(child: MyText(text: numberText, fontSize: 41, height: 1.71, textAlign: TextAlign.start)),

                14.sbw,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      MyText(text: title, fontSize: 19, height: 1.71, softWrap: true, textAlign: TextAlign.start),

                      2.sbh,

                      MyText(text: subTitle, fontSize: 14, color: R.theme.grey, softWrap: true, textAlign: TextAlign.start)

                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}