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

class ActivateEsim extends GetView<GuideController> {
  const ActivateEsim({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xff050915),
      statusBarIconBrightness: Brightness.light,
    ));
    final VoidCallback? onGotIt = () => {};

    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Activate Your eSIM', fontSize: 20),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: 16.all,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                ReminderCard(title: 'Reminder', subtitle: 'Activate only at your destination.', onGotIt: onGotIt),

                18.sbh,
                
                MyText(text: 'Activate only at your destination.', fontSize: 15, color: R.theme.grey),

                18.sbh,

                VideoPlaceholder(),

                22.sbh,

                InfoBanner(message: 'You’re done! Now your data is available for use.'),

                49.sbh,
                
                MyText(text: 'Check your connection', fontSize: 15, color: R.theme.grey),

                44.sbh,

                const Bullets(items: [
                  'One way is to check the top bar on your phone. Check that the signal icon, has at least one bar.',
                  'Or you can go to settings, then Cellular data, select Wilixify Soft and verify data toggle roaming is on.',
                ]),
                
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

}
