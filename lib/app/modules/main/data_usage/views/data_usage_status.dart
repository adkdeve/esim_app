import 'package:flutter/material.dart';
import 'package:flutter_semi_circle/flutter_semi_circle.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/my_text.dart';
import '../controllers/data_usage_controller.dart';

class DataUsageStatus extends GetView<DataUsageController> {
  const DataUsageStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Data Usage Status', fontSize: 20),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.sbh,

                Obx(() => Column(
                  children: [
                    MyText(
                      text: controller.planName.value,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: R.theme.white,
                    ),
                    15.sbh,
                    MyText(
                      text: "Status: ${controller.status.value}",
                      fontSize: 12,
                      color: controller.status.value == 'ACTIVE' ? Colors.green : Colors.grey,
                    ),
                  ],
                )),

                20.sbh,

                // --- DYNAMIC GAUGE ---
                Obx(() => FlutterSemiCircle(
                  height: 200,
                  width: 200,
                  thickness: 15,
                  backgroundColor: R.theme.grey.withOpacity(0.2), // Light grey background for empty part
                  foregroundColor: R.theme.primary, // Or Color(0xff9D0000)
                  totalValue: 100,
                  currentValue: controller.remainingPercentage, // Dynamic %
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyText(
                        text: controller.remainingDataStr, // Dynamic Text
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 2),
                      const MyText(
                        text: 'Remaining Data',
                        fontSize: 14,
                      ),
                    ],
                  ),
                )),

                60.sbh,

                // --- DYNAMIC STATS ---
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        MyText(
                          text: controller.usedDataStr, // Dynamic Used
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const MyText(
                          text: 'USED DATA',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    40.sbw,
                    Column(
                      children: [
                        MyText(
                          text: controller.totalDataStr, // Dynamic Total
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const MyText(
                          text: 'TOTAL DATA',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}