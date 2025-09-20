import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/my_text.dart';
import 'package:pcom_app/common/widgets/primary_button.dart';

import '../../../../../common/widgets/my_text_form_field.dart';
import '../controllers/data_usage_controller.dart';
import 'data_usage_status.dart';

class DataUsageView extends GetView<DataUsageController> {
  const DataUsageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: MyText(text: 'Data Usage Status', fontSize: 20),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Stack(
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
        
                  Column(
                    children: [
        
                      Container(
                        constraints: BoxConstraints(maxWidth: 260),
                          child:
                          MyText(
                            text: 'Enter Your Previous Order No or eSIM ID:',
                            fontSize: 18,
                            softWrap: true,
                          )
                      ),
        
                      15.sbh,
        
                      MyTextFormField(
                        hinttxt: 'Enter here',
                        controller: controller.esimIDController,
                      ),
        
                      35.sbh,
        
                      PrimaryButton(
                        onPressed: () {
                          Get.to(DataUsageStatus());
                        },
                        text: 'Get a Sim Details',
                        color: R.theme.primary,
        
                      )
                    ],
                  ),
        
                  35.sbh,
        
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        
                      MyText(text: 'For Top-up:', fontSize: 18),
        
                      5.sbh,
        
                      MyText(text: 'Enter existing eSIM Order Number', fontSize: 14, opacity: 0.5),
        
                      10.sbh,
        
                      MyTextFormField(
                        hinttxt: 'Enter here',
                        controller: controller.esimIDController,
                      ),
        
                      12.sbh,
        
                      MyText(
                        text: 'Enter your previous order number and choose from the available packages. The data will be instantly added to your existing eSIM.',
                        fontSize: 12,
                        opacity: 0.5,
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
        
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: 12.all,
        child: SizedBox(
          height: 56,
          child: PrimaryButton(color: R.theme.primary, text: 'Card Payment', onPressed: () => {}),
        ),
      ),
    );
  }
}
