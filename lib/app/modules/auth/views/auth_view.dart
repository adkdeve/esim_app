import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pcom_app/app/modules/auth/views/signup_view.dart';

import '../../../../common/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthView'),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              'AuthView is working',
              style: TextStyle(fontSize: 20),
            ),

            Spacer(),

            PrimaryButton(
              smoothness: 0,
              text: 'SignUp Page',
              onPressed: () {
                Get.to(() => SignupView());
              },
            ),
          ]
      ),
    );
  }
}
