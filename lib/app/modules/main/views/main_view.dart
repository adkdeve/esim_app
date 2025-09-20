import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/modules/main/profile/views/change_password.dart';
import 'package:pcom_app/app/modules/main/profile/views/contact_us.dart';
import 'package:pcom_app/app/modules/main/profile/views/faq_view.dart';
import 'package:pcom_app/app/modules/main/profile/views/privacy_policy.dart';
import 'package:pcom_app/app/modules/main/profile/views/terms_and_condition.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../../common/widgets/smooth_rectangle_border.dart';
import '../../../core/core.dart';
import '../../../routes/app_pages.dart';
import '../controllers/main_controller.dart';
import '../data_usage/controllers/data_usage_controller.dart';
import '../data_usage/views/data_usage_view.dart';
import '../profile/controllers/profile_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: Container(
        width: .7.sw,
        margin: const EdgeInsets.only(bottom: 40),
        decoration: ShapeDecoration(
          shape: const SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(26),
              bottomRight: Radius.circular(26),
            ),
          ),
          color: R.theme.secondary,
        ),
        child: Column(
          children: [
            const Spacer(),
            (AppConfig.defaultPadding / 2).sbh,
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
            (AppConfig.defaultPadding / 3).sbh,
            DrawerItem(
              title: 'Edit Profile',
              icon: 'assets/icons/ic_edit_profile.svg',
              showArrow: true,
              onTap: () {
                // controller.closeDrawer();
                // controller.selectedIndex.value = 3;
              },
            ),
            DrawerItem(
              title: "Notifications",
              icon: 'assets/icons/ic_notification.svg',
              onTap: () {
                // controller.closeDrawer();
              },
                trailing: Switch(
                  value: true,
                  onChanged: (val) {
                    val = false;
                  },
                ),
            ),
            DrawerItem(
              title: 'Contact Us',
              icon: 'assets/icons/ic_phone.svg',
              showArrow: true,
              onTap: () {
                // controller.closeDrawer();
                // Get.toNamed(Routes.CONTACT_US);
              },
            ),
            DrawerItem(
              title: "Language",
              icon: 'assets/icons/ic_language.svg',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    text: "English",
                    fontSize: 14,
                    height: 1.4,
                    letterSpacing: 0.18,
                    color: R.theme.grey,
                  ),
                  8.sbw,
                  const Icon(Icons.arrow_forward_ios, size: 18),
                ],
              ),
              onTap: () {},
            ),
            DrawerItem(
              title: 'Data Usage Status',
              icon: 'assets/icons/ic_data_usage.svg',
              showArrow: true,
              onTap: () {
                // controller.closeDrawer();
                // Get.toNamed(Routes.DATA_USAGE);
              },
            ),
            DrawerItem(
              title: 'Privacy Policy',
              icon: 'assets/icons/ic_privacy.svg',
              showArrow: true,
              onTap: () {
                // controller.closeDrawer();
                // Get.toNamed(Routes.PRIVACY_POLICY);
              },
            ),
            DrawerItem(
              title: 'Terms & Conditions',
              icon: 'assets/icons/ic_terms.svg',
              showArrow: true,
              onTap: () {
                // controller.closeDrawer();
                // Get.toNamed(Routes.TERMS_AND_CONDITION);
              },
            ),
            DrawerItem(
              title: 'FAQ\'s',
              icon: 'assets/icons/ic_faqs.svg',
              showArrow: true,
              onTap: () {
                // controller.closeDrawer();
                // Get.toNamed(Routes.FAQ);
              },
            ),
            DrawerItem(
              title: 'Change Password',
              icon: 'assets/icons/ic_change_password.svg',
              showArrow: true,
              onTap: () {
                // controller.closeDrawer();
                // Get.toNamed(Routes.CHANGE_PASSWORD);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
          () => Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              // controller.selectedIndex.value = index;
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/ic_shop.svg"),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/ic_esim.svg"),
                label: 'My eSIMs',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/ic_guide.svg"),
                label: 'Guides',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/ic_profile.svg"),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.showArrow = false,
    this.trailing,
  });

  final String title;
  final String icon;
  final VoidCallback? onTap;
  final bool showArrow;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: R.theme.transparent,
      child: ListTile(
        title: MyText(
          text: title,
          fontSize: 15,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w400,
          height: 1.4,
          letterSpacing: 0.18,
          color: R.theme.white,
        ),
        leading: SvgPicture.asset(
          icon,
          height: 24,
          width: 24,
        ),
        trailing: trailing ??
            (showArrow
                ? const Icon(Icons.arrow_forward_ios, size: 18)
                : null),
        onTap: onTap,
      ),
    );
  }

}