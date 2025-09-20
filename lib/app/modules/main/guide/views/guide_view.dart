import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/primary_button.dart';
import '../../../../../common/widgets/custom_guide_card.dart';
import '../../../../../common/widgets/my_text.dart';
import '../controllers/guide_controller.dart';
import 'activate_esim.dart';
import 'install_esim.dart';

class GuideView extends GetView<GuideController> {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
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

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Stack(
                    children: [

                      Positioned.fill(
                        child: SvgPicture.asset(
                          "assets/images/header_background.svg",
                          fit: BoxFit.cover,
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Center(child: MyText(text: 'Guide', fontSize: 20)),

                            22.sbh,

                            Container(
                              constraints: BoxConstraints(maxWidth: 250),
                                child: MyText(
                                  text: "How Wilixify ESIM Works?",
                                  fontSize: 28,
                                  letterSpacing: -0.53,
                                  height: 1.5,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                )
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),

                  10.sbh,

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MyText(text: "This is everything you love about regular mobile network, Connecting you when you travel", fontSize: 15, height: 1.2, softWrap: true, textAlign: TextAlign.start, opacity: 0.6),

                        30.sbh,

                        CustomGuide(numberText: "01.", title: "Install your eSim", subTitle: "Install before your trip, you must have an internet connection.",
                          onTap: () {
                            Get.to(InstallEsim());
                          },
                        ),

                        17.sbh,

                        CustomGuide(numberText: "02.", title: "Activate your eSim", subTitle: "Activate only at your destination, data will began to consume.",
                          onTap: () {
                            Get.to(ActivateEsim());
                          },
                        ),

                        17.sbh,
                        
                        MyText(text: 'Save the guide in your phone', fontSize: 19, color: R.theme.grey, fontWeight: FontWeight.w700, textAlign: TextAlign.start),

                        9.sbh,

                        CustomGuide(numberText: "", title: "Download the PDF guide", subTitle: "Save it in your phone, in case you don’t have internet connection.",),

                        15.sbh,

                        MyText(text: 'Do you need help?', fontSize: 19, color: R.theme.grey, fontWeight: FontWeight.w700, textAlign: TextAlign.start),

                        15.sbh,

                        Container(
                          decoration: BoxDecoration(
                            color: R.theme.secondary,
                            borderRadius: 12.radius,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Color(0xFFD8D8D8),
                                  backgroundImage: AssetImage('assets/icons/ic_customer_support.png'),
                                ),

                                16.sbh,

                                Container(
                                  constraints: BoxConstraints(maxWidth: 200),
                                    child: MyText(text: 'We are here for you! Enjoy 24/7 customer Support.', fontSize: 14, fontWeight: FontWeight.w400, softWrap: true)),

                                16.sbh,

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                                  child: Container(
                                      width: 264,
                                      height: 48,
                                      child: PrimaryButton(text: 'Let’s talk!', color: R.theme.primary, iconBtn: true, icon: 'assets/icons/ic_whatsapp_icon.svg', onPressed: ()=> {})),
                                )
                              ],
                            ),
                          ),
                        )

                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
