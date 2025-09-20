import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/auth/views/signup_view.dart';
import 'package:pcom_app/common/widgets/my_text.dart';

import '../../../routes/app_pages.dart';
import '../../auth/views/signin_view.dart';

class FinalOnboarding extends StatelessWidget {
  const FinalOnboarding({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/background.svg",
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              allowDrawingOutsideViewBox: true,
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                "assets/images/header_background.svg",
                width: 912,
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: 24.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 182, height: 62,
                      child: Image.asset('assets/images/logo.png')),
                  35.sbh,
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700, height: 1.4),
                      children: [
                        TextSpan(text: "Welcome to the ", style: TextStyle(color: Colors.white)),
                        TextSpan(text: "best\n", style: TextStyle(color: Color(0xFFB87333))),
                        TextSpan(text: "travel eSIM", style: TextStyle(color: Color(0xFFB87333))),
                      ],
                    ),
                  ),
                  52.sbh,
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: "Unlimited data plans.", fontSize: 18, height: 1.96),
                        12.sbh,
                        MyText(text: "Reliable internet up to 5G speed.", fontSize: 18, height: 1.96),
                        12.sbh,
                        MyText(text: "Data Sharing.", fontSize: 18, height: 1.96),
                        12.sbh,
                        MyText(text: "24/7 support.", fontSize: 18, height: 1.96),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: CtaCard(
                          title: 'Already got an eSIM',
                          onTap: () => Get.offAllNamed(Routes.SIGNIN),
                        ),
                      ),
                      16.sbw,
                      Expanded(
                        child: CtaCard(
                          title: 'Buy an eSIM',
                          outlined: true,
                          onTap: () => Get.offAllNamed(Routes.SIGNUP),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CtaCard extends StatelessWidget {
  const CtaCard({
    super.key,
    required this.title,
    required this.onTap,
    this.background = const Color(0xFF8C5A22), // brown
    this.foreground = Colors.white,
    this.outlined = false,
    this.height = 100,
    this.radius = 10,
  });

  final String title;
  final VoidCallback onTap;
  final Color background;
  final Color foreground;
  final bool outlined;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final cardColor = outlined ? Colors.white : background;
    final textColor = outlined ? const Color(0xFF8C5A22) : foreground;
    final arrowColor = textColor;

    return Material(
      color: cardColor,
      elevation: 10,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [

                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: MyText(
                      text: title,
                      softWrap: true,
                      color: textColor,
                      textAlign: TextAlign.start,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.42,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.arrow_forward,
                    color: arrowColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
