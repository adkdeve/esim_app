import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/my_text.dart';

class LoginRequiredView extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final String bodyText;

  const LoginRequiredView({
    super.key,
    required this.onLoginPressed,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/background.svg",
            fit: BoxFit.fill,
            alignment: Alignment.bottomCenter,
            allowDrawingOutsideViewBox: true,
          ),
        ),

        // Content
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: R.theme.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.lock_outline_rounded, size: 60, color: R.theme.primary),
                ),
                20.sbh,
                MyText(
                  text: "Login Required",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: R.theme.black,
                ),
                10.sbh,
                MyText(
                  text: bodyText,
                  fontSize: 14,
                  color: R.theme.grey,
                  textAlign: TextAlign.center,
                ),
                30.sbh,
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: onLoginPressed,
                    child: const Text(
                        "Go to Login",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}