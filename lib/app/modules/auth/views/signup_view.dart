import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/auth/views/signin_view.dart';
import 'package:pcom_app/common/widgets/my_text.dart';
import 'package:pcom_app/common/widgets/primary_button.dart';

import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/my_text_form_field.dart';
import '../../../../common/widgets/social_button_widget.dart';
import '../controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignupView extends GetView<AuthController> {
  SignupView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              40.sbh,

              Image.asset(
                'assets/images/logo.png',
                width: 220,
                height: 60,
              ),

              20.sbh,

              MyText(text: 'Sign Up', fontSize: 24, fontWeight: FontWeight.bold, color: R.theme.color600),

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
                text: 'Sign up',
                onPressed: () {

                },
              ),

              10.sbh,

              Padding(
                padding: 8.horizontal,
                child: MyText(text: 'Or', fontSize: 14, opacity: 0.4, fontWeight: FontWeight.bold),
              ),

              10.sbh,

              SocialButton(
                icon: 'assets/icons/ic_google.svg',
                text: 'Continue with Google',
                backgroundColor: R.theme.surface,
                textColor: Colors.black,
              ),

              SocialButton(
                icon: Icons.facebook,
                text: 'Continue with Facebook',
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),

              SocialButton(
                icon: Icons.apple,
                text: 'Continue with Apple',
                backgroundColor: Colors.grey.shade800,
                textColor: Colors.white,
              ),

              24.sbh,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyText(text: "Already have an account? ",fontSize: 12, opacity: 0.5),
                  14.sbw,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SigninView());
                    },
                    child: MyText(
                      text: 'Log in',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}