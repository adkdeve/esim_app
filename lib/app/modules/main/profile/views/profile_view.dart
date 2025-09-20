import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/main/profile/views/privacy_policy.dart';
import 'package:pcom_app/app/modules/main/profile/views/profile_edit.dart';
import 'package:pcom_app/app/modules/main/profile/views/terms_and_condition.dart';
import '../../../../../common/widgets/my_text.dart';
import '../controllers/profile_controller.dart';
import 'change_password.dart';
import 'contact_us.dart';
import 'faq_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'My Profile', fontSize: 20),
        centerTitle: true,
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

          Column(
            children: [
              Stack(
                  children: [

                    Positioned.fill(
                      child: SvgPicture.asset(
                        "assets/images/header_background.svg",
                        fit: BoxFit.fill,
                      ),
                    ),

                    Container(
                      width: 1.sw,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: R.theme.primary,
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg',
                              ),
                            ),
                          ),

                          12.sbh,

                          MyText(
                            text: 'Samilon',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: R.theme.primary,
                          ),

                        ],
                      ),
                    ),
                  ]
              ),

              Padding(
                padding: 16.all,
                child: Column(
                  children: [

                    GestureDetector(
                      onTap: () {
                        Get.to(ProfileEdit());
                      },
                      child: OptionItem(iconData: Icons.account_circle_outlined,title: 'Edit Profile', isToggle: false),
                    ),

                    GestureDetector(
                      onTap: () {

                      },
                      child: OptionItem(
                        iconData: Icons.notifications_active_outlined,
                        title: 'Notifications',
                        isToggle: true,
                        isActive: true,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(ContactUSView());
                      },
                      child: OptionItem(iconData: Icons.call,title: 'Contact Us', isToggle: false),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(PrivacyView());
                      },
                      child: OptionItem(iconData: Icons.lock_outline,title: 'Privacy Policy', isToggle: false),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(TermsView());
                      },
                      child: OptionItem(iconData: Icons.info_outline_rounded,title: 'Terms & Conditions', isToggle: false),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(FaqView());
                      },
                      child: OptionItem(iconData: Icons.info_outline_rounded,title: "FAQ's", isToggle: false),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(ChangePasswordView());
                      },
                      child: OptionItem(iconData: Icons.info_outline_rounded,title: 'Change Password', isToggle: false),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}

class OptionItem extends StatelessWidget {
  final String title;
  final bool isToggle;
  final bool isActive;
  final IconData iconData;

  OptionItem({
    required this.iconData,
    required this.title,
    required this.isToggle,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [

          Icon(iconData, color: R.theme.primary),

          10.sbw,

          MyText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: R.theme.white,
            textAlign: TextAlign.start,
          ),

          Spacer(),

          if (isToggle)
            Icon(
              isActive ? Icons.toggle_on_sharp : Icons.toggle_off_sharp,
              color: isActive ? R.theme.primary : R.theme.grey,
              size: 40,
            ),
        ],
      ),
    );
  }
}

