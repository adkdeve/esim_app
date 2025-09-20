import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/app/modules/main/guide/controllers/guide_controller.dart';
import 'package:pcom_app/common/widgets/my_text.dart';
import '../../../../../common/widgets/bullet_points.dart';
import '../../../../../common/widgets/info_banner.dart';
import '../../../../../common/widgets/reminder_card.dart';
import '../../../../../common/widgets/video_placeholder.dart';

class InstallEsim extends GetView<GuideController> {
  const InstallEsim({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xff050915),
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Install Your eSIM', fontSize: 20),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: 16.all,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [

                Padding(
                  padding: 10.horizontal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: R.theme.secondary,
                      borderRadius: 30.radius,
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: R.theme.primary,
                        borderRadius: 30.radius,
                      ),
                      labelColor: R.theme.white,
                      unselectedLabelColor: R.theme.white,
                      indicatorPadding: 5.all,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: R.theme.transparent,
                      tabs: [
                        Tab(text: 'Manual Codes'),
                        Tab(text: 'QR Code'),
                      ],
                    ),
                  ),
                ),

                20.sbh,

                Expanded(
                  child: TabBarView(
                    children: [
                      _buildManualCodeSection(context),
                      _buildQRCodeSection(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Stack(
        children: [

          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/header_background.svg",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          Padding(
            padding: 16.all,
            child: Column(
              children: [

                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [

                      Padding(
                        padding: 10.horizontal,
                        child: Container(
                          decoration: BoxDecoration(
                            color: R.theme.secondary,
                            borderRadius: 30.radius,
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: R.theme.primary,
                              borderRadius: 30.radius,
                            ),
                            labelColor: R.theme.white,
                            unselectedLabelColor: R.theme.white,
                            indicatorPadding: 5.all,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: R.theme.transparent,
                            tabs: [
                              Tab(text: 'Manual Codes'),
                              Tab(text: 'QR Code'),
                            ],
                          ),
                        ),
                      ),

                      20.sbh,

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6 - 45,
                        child: TabBarView(
                          children: [

                          ],
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ]
    );
  }

  Widget _buildManualCodeSection (BuildContext context) {
    final VoidCallback? onGotIt = () => {};

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          MyText(
              text: 'You will only need to copy and paste the manual codes found in My eSIMs > Install and activate.',
              fontSize: 15,
              textAlign: TextAlign.start,
              color: R.theme.grey,
              softWrap: true
          ),

          16.sbh,

          ReminderCard(title: 'Reminder', subtitle: 'Install before your trip.',onGotIt: onGotIt),

          19.sbh,

          const Bullets(items: [
            'Install before your trip.',
            'You must have internet connection.',
            'Use the SM-DP+ Address and Activation Code found in My eSIMs > Install and activate > Manual Codes.',
            'Follow the next steps:',
          ]),

          25.sbh,

          VideoPlaceholder(),

        ],
      ),
    );
  }

  Widget _buildQRCodeSection (BuildContext context) {
    final VoidCallback? onGotIt = () => {};

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          MyText(
              text: 'Choose this option if you have the QR on a different device, and you can scan it.',
              fontSize: 15,
              textAlign: TextAlign.start,
              color: R.theme.grey,
              softWrap: true
          ),
      
          16.sbh,

          ReminderCard(title: 'Reminder', subtitle: 'Install before your trip.',onGotIt: onGotIt),
      
          19.sbh,
      
          const Bullets(items: [
            'You must have internet connection.',
            'Install before your trip.',
            'You must have the QR code in a different device so you can scan it.',
            'Follow the next steps:',
          ]),
      
          25.sbh,

          VideoPlaceholder(),

          22.sbh,

          InfoBanner(message: 'At the end of the installation, you can proceed to activate.')
        ],
      ),
    );
  }

}



