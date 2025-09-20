import 'package:get/get.dart';
import 'package:pcom_app/app/modules/auth/views/signin_view.dart';
import 'package:pcom_app/app/modules/auth/views/signup_view.dart';
import 'package:pcom_app/app/modules/main/profile/views/change_password.dart';
import 'package:pcom_app/app/modules/main/profile/views/contact_us.dart';
import 'package:pcom_app/app/modules/main/profile/views/faq_view.dart';
import 'package:pcom_app/app/modules/main/profile/views/privacy_policy.dart';
import 'package:pcom_app/app/modules/main/profile/views/profile_edit.dart';
import 'package:pcom_app/app/modules/main/profile/views/terms_and_condition.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/card_details/bindings/card_details_binding.dart';
import '../modules/main/card_details/views/card_details_view.dart';
import '../modules/main/data_usage/bindings/data_usage_binding.dart';
import '../modules/main/data_usage/views/data_usage_view.dart';
import '../modules/main/guide/bindings/guide_binding.dart';
import '../modules/main/guide/views/guide_view.dart';
import '../modules/main/home/bindings/home_binding.dart';
import '../modules/main/home/views/home_view.dart';
import '../modules/main/my_esim/bindings/my_esim_binding.dart';
import '../modules/main/my_esim/views/my_esim_view.dart';
import '../modules/main/profile/bindings/profile_binding.dart';
import '../modules/main/profile/views/profile_view.dart';
import '../modules/main/views/main_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      children: [
        GetPage(
          name: _Paths.SIGNIN,
          page: () => SigninView(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: _Paths.SIGNUP,
          page: () => SignupView(),
          binding: AuthBinding(),
        ),
      ]
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: _Paths.DATA_USAGE,
          page: () => const DataUsageView(),
          binding: DataUsageBinding(),
        ),
        GetPage(
          name: _Paths.CARD_DETAILS,
          page: () => const CardDetailsView(countryName: '', imageUrl: '',),
          binding: CardDetailsBinding(),
        ),
        GetPage(
          name: _Paths.PROFILE,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.PROFILE_EDIT,
          page: () => const ProfileEdit(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.CHANGE_PASSWORD,
          page: () => ChangePasswordView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.CONTACT_US,
          page: () => const ContactUSView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.FAQ,
          page: () => const FaqView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.PRIVACY_POLICY,
          page: () => const PrivacyView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.TERMS_AND_CONDITION,
          page: () => const TermsView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.GUIDE,
          page: () => const GuideView(),
          binding: GuideBinding(),
        ),
        GetPage(
          name: _Paths.MY_ESIM,
          page: () => MyEsimView(),
          binding: MyEsimBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
