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

                FlutterSemiCircle(
                  height: 200,
                  width: 200,
                  thickness: 15,
                  backgroundColor: R.theme.white,
                  foregroundColor: Color(0xff9D0000),
                  totalValue: 100,
                  currentValue: 35,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      MyText(
                        text: '123 MB',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),

                      SizedBox(
                        height: 2,
                      ),

                      MyText(
                        text: 'Remaining Data',
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),

                60.sbh,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [

                        MyText(
                          text: '1.88 GB',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),

                        MyText(
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
                          text: '2 GB',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),

                        MyText(
                          text: 'Total DATA',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
