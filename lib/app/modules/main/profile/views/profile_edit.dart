import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/primary_button.dart';
import '../../../../../common/widgets/login_required_view.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileEdit extends GetView<ProfileController> {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {

        if (controller.mainController.isGuest.value) {
          return LoginRequiredView(
            bodyText: "Please login first to view and manage your profile.",
            onLoginPressed: () {
              Get.offAllNamed(Routes.SIGNIN);
            },
          );
        }

        return _buildAuthenticatedContent(context);
      }),
    );
  }

  Widget _buildAuthenticatedContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'My Profile', fontSize: 20),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => controller.logout(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
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
              padding: 24.all,
              child: Column(
                children: [
                  50.sbh,
                  Column(
                    children: [
                      TextFormField(
                        controller: controller.name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: R.theme.primary),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {},
                      ),

                      24.sbh,

                      TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: R.theme.primary),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      // 24.sbh,
                      // Phone Number Field (Commented out in original)
                      // 24.sbh,
                      //
                      // TextFormField(
                      //   controller: controller.birthdayController,
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     labelText: 'Birthday',
                      //     labelStyle: TextStyle(color: R.theme.primary),
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   onTap: () => controller.pickDate(context),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please select your birthday';
                      //     }
                      //     return null;
                      //   },
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: 12.all,
        child: SizedBox(
          height: 56,
          child: PrimaryButton(
              color: R.theme.primary,
              text: 'Save',
              onPressed: () {
                var data = {
                  'email': controller.mainController.user?.userEmail,
                  'display_name': controller.name.text,
                };
                controller.mainController.postApi(jsonEncode(data), ApisUrl.updateProfile);
              }
          ),
        ),
      ),
    );
  }
}