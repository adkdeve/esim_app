import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../../common/widgets/primary_button.dart';
import '../../../core/core.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';
import 'final_onboarding.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: R.theme.backgroundClr,
        body: Stack(
          children: [

            PageView.builder(
              controller: controller.pageController,
              itemCount: controller.onboardingData.length,
              onPageChanged: (index) => controller.currentPage.value = index,
              itemBuilder: (context, index) {
                final data = controller.onboardingData[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // 1. The Image
                    Image.asset(
                      data['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),

                    // 2. The Gradient Overlay
                    // (Kept here so it swipes with image, ensuring text readability)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.15, 0.55, 1.0],
                            colors: [
                              Colors.transparent,
                              const Color(0xFF0B1016).withOpacity(0.55),
                              const Color(0xFF0B1016),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 3. The Rich Text
                    // We use Positioned to place it above the static buttons
                    Positioned(
                      bottom: 180, // Leave space for the static buttons below
                      left: 24,
                      right: 24,
                      child: data['title'],
                    ),
                  ],
                );
              },
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextButton(
                    onPressed: () {
                      controller.saveSkip();
                      Get.offAllNamed(Routes.MAIN);
                    },
                    child: MyText(
                      text: 'SKIP',
                      color: Colors.white,
                      fontSize: 16,
                      height: 2,
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      // The Dots (Page Indicator)
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.onboardingData.length,
                                (index) {
                              final bool active =
                                  controller.currentPage.value == index;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: 4.horizontal,
                                width: active ? 10 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: active
                                      ? R.theme.primary
                                      : Colors.white.withOpacity(0.35),
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                          ),
                        );
                      }),

                      24.sbh,

                      // The Buttons (Next / Login)
                      Obx(() {
                        final bool isLastPage = controller.currentPage.value ==
                            controller.onboardingData.length - 1;
                        return Column(
                          children: [
                            PrimaryButton(
                              color: R.theme.primary,
                              text: isLastPage ? 'Continue' : 'Next',
                              onPressed: () {
                                if (isLastPage) {
                                  Get.offAllNamed(Routes.FINALONBOARDING);
                                } else {
                                  controller.pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                            12.sbh,

                            if (!isLastPage)
                              TextButton(
                                onPressed: () =>
                                    Get.offAllNamed(Routes.SIGNIN),
                                child: MyText(
                                  text: 'Log in',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            else
                              const SizedBox(height: 48),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}