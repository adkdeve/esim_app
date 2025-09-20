import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/auth/views/signup_view.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../../common/widgets/primary_button.dart';
import '../../../../common/widgets/social_button_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/auth_controller.dart';

class SigninView extends GetView<AuthController> {
  SigninView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
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

          SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.sbh,

                Image.asset(
                  'assets/images/logo.png',
                  width: 220,
                  height: 60,
                ),

                20.sbh,

                MyText(
                  text: 'Log in',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),

                24.sbh,

                CustomTextField(
                  label: 'Email',
                  hintText: 'olivia@untitledui.com',
                  controller: emailController,
                ),

                10.sbh,

                CustomTextField(
                  label: 'Password',
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),

                24.sbh,

                PrimaryButton(
                  color: R.theme.primary,
                  text: 'Log in',
                  onPressed: () {
                    Get.offAllNamed(Routes.MAIN);
                  },
                ),

                10.sbh,

                Padding(
                  padding: 8.horizontal,
                  child: MyText(
                    text: 'Or',
                    fontSize: 14,
                    opacity: 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                10.sbh,

                SocialButton(
                  icon: 'assets/icons/ic_google.svg',
                  text: 'Continue with Google',
                  backgroundColor: R.theme.secondary,
                  textColor: R.theme.textColor,
                  borderColor: R.theme.transparent,
                ),

                24.sbh,
              ],
            ),
          ),
        )
        ],
      ),
      bottomNavigationBar: Padding(

        padding: const EdgeInsets.only(bottom: 40),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const MyText(
              text: "Don't have an account? ",
              fontSize: 14,
              opacity: 0.5,
            ),

            14.sbw,

            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SIGNUP);
              },
              child: MyText(
                text: 'Sign up',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}