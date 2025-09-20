import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/main/profile/controllers/profile_controller.dart';
import 'package:pcom_app/common/widgets/custom_text_field.dart';
import 'package:pcom_app/common/widgets/my_text.dart';
import 'package:pcom_app/common/widgets/primary_button.dart';

class ChangePasswordView extends GetView<ProfileController> {
  ChangePasswordView({super.key});

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Change Password", fontSize: 20),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
        
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/images/background.svg",
                fit: BoxFit.fill,
                alignment: Alignment.bottomCenter,
                allowDrawingOutsideViewBox: true,
              ),
            ),
        
            SingleChildScrollView(
              child: Padding(
                padding: 16.all,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
        
                    10.sbh,
        
                    MyText(
                      height: 1.5,
                      text: "You will be logged out of all sessions except this one to protect your account if anyone is trying to gain access.\n\n"
                          "Your password must be at least 6 characters and should include a combination of numbers, letters and special characters.",
                      fontSize: 12,
                      softWrap: true,
                      opacity: 0.5,
                      textAlign: TextAlign.justify,
                    ),
        
                    12.sbh,
        
                    CustomTextField(label: 'Current Password', hintText: '', controller: currentPasswordController, obscureText: true),
        
                    12.sbh,
        
                    CustomTextField(label: 'New Password', hintText: '', controller: newPasswordController, obscureText: true),
        
                    12.sbh,
        
                    CustomTextField(label: 'Confirm New Password', hintText: '', controller: confirmPasswordController, obscureText: true),
        
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox(
          height: 56,
          child: PrimaryButton(color: R.theme.primary, text: 'Save', onPressed: () => {}),
        ),
      ),
    );
  }

}
