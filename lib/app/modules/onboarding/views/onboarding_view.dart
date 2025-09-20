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

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: R.theme.backgroundClr,
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.onboardingData.length,
        onPageChanged: (index) => controller.currentPage.value = index,
        itemBuilder: (context, index) {
          final data = controller.onboardingData[index];
          return Stack(
            fit: StackFit.expand,
            children: [

              Image.asset(
                data['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

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

              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextButton(
                      onPressed: () => {
                        Get.offAllNamed(Routes.SIGNUP)
                      },
                      child: MyText(
                        text: 'SKIP',
                        color: Colors.white,
                        fontSize: 16,
                        height: 2
                      ),
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: data['title'],
                        ),

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
                                    Get.to(FinalOnboarding());
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
                                  onPressed: () => Get.offAllNamed(Routes.SIGNIN),
                                  child: MyText(
                                    text: 'Log in',
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
