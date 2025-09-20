import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';

import '../../../../../common/widgets/build_image.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../../common/widgets/primary_button.dart';
import '../../../../../common/widgets/smooth_rectangle_border.dart';
import '../controllers/card_details_controller.dart';
import 'checkout_screen.dart';

class CardDetailsView extends GetView<CardDetailsController> {
  const CardDetailsView({super.key, required this.countryName, required this.imageUrl });
  final String? imageUrl;
  final String? countryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Card Detail', fontSize: 20),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.arrow_back)
        ),
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

          SingleChildScrollView(
          child: Padding(
            padding: 16.all,
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(
                    left: AppConfig.defaultPadding,
                  ),
                  child: SizedBox(
                    height: 24,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.category.length,
                      itemBuilder: (c, i) {
                        return Obx(() {
                          var isSelected = i == controller.selectedIndex.value;
                          return GestureDetector(
                            onTap: () {
                              controller.selectedIndex.value = i;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: ShapeDecoration(
                                color: isSelected
                                    ? R.theme.primary
                                    : R.theme.secondary,
                                shape: SmoothRectangleBorder(
                                  smoothness: 1,
                                  borderRadius: BorderRadius.circular(
                                    AppConfig.defaultPadding,
                                  ),
                                  side: BorderSide(
                                    width: 0.5,
                                  ),
                                ),

                              ),
                              child: Center(
                                child: MyText(
                                  text: controller.category[i],
                                  fontSize: 12,
                                  color: isSelected
                                      ? R.theme.white
                                      : R.theme.color600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),

                30.sbh,

                Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Recommendation',
                    fontSize: 18,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                4.sbh,

                Container(
                  width: 330,
                  height: 150,
                  decoration: BoxDecoration(
                    color: R.theme.white,
                    borderRadius: 20.radius,
                  ),
                  child: Stack(
                    children: [

                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/icons/ic_credit_card_background.svg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: 16.all,
                        child: Column(
                          children: [

                            Row(
                              children: [

                                ClipRRect(
                                  borderRadius: 50.radius,
                                  child: buildImage(
                                    imageUrl ?? 'https://flagcdn.com/w320/cn.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                10.sbw,

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    MyText(
                                      text: countryName ?? 'Country Name',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),

                                    MyText(
                                        text: 'eSIM',
                                        fontSize: 10,
                                        color: Colors.grey
                                    ),
                                  ],
                                ),

                                Spacer(),

                                buildImage('assets/images/ic_sim.png', width: 32, height: 26),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 40,top: 2),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                  color: R.theme.black,
                                  text: '\$5.00 – \$79.99',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            20.sbh,

                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Plan Benefits:',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: R.theme.black,
                              ),
                            ),

                            8.sbh,

                            Row(
                              children: [
                                Row(
                                  children: [

                                    buildImage('assets/icons/ic_no_data.svg', width: 12, height: 12, color: R.theme.grey),

                                    8.sbw,

                                    MyText(text: 'No share data', fontSize: 10, color: R.theme.grey),
                                  ],
                                ),

                                8.sbw,

                                Row(
                                  children: [

                                    buildImage('assets/icons/ic_speed.svg', width: 12, height: 12, color: R.theme.grey),

                                    8.sbw,

                                    MyText(text: 'Up to 5G speed',fontSize: 10, color: R.theme.grey),
                                  ],
                                ),

                                8.sbw,

                                Row(
                                  children: [

                                    Icon(Icons.calendar_month_outlined, size: 12, color: R.theme.grey),

                                    8.sbw,

                                    MyText(text: '7 days', fontSize: 10, color: R.theme.grey),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                20.sbh,

                Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: '8 Available Plans',
                    fontSize: 18,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                20.sbh,

                Column(
                  children: controller.plans.map((plan) {
                    return Obx(
                          () => Column(
                        children: [

                          Row(
                            children: [

                              MyText(
                                text: '${plan['data']}',
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,
                              ),

                              10.sbw,

                              MyText(
                                text: '${plan['validity']}',
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,
                              ),

                              Spacer(),

                              Radio<int>(
                                value: plan['index'],
                                groupValue: controller.selectedPlanIndex.value,
                                onChanged: (int? value) {
                                  controller.selectedPlanIndex.value = value!;
                                  controller.quantity.value = 1;
                                },
                                activeColor: R.theme.white,
                              ),
                            ],
                          ),

                          Divider(color: R.theme.grey),
                        ],
                      ),
                    );
                  }).toList(),
                ),

              ],
            ),
          ),
        ),
        ]
      ),
      bottomNavigationBar: Obx(() {
        final idx = controller.selectedPlanIndex.value;
        if (idx == -1) return const SizedBox.shrink();

        final selectedPlan = controller.plans[idx];
        final int qty = controller.quantity.value;
        final double totalPrice = selectedPlan['price'] * qty;
        final String planDescription = "${selectedPlan['data']}, ${selectedPlan['validity']}";
        
        return SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 130,
            decoration: BoxDecoration(
              color: R.theme.backgroundClr,
            ),
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
            
                Row(
                  children: [
            
                    MyText(text: planDescription, fontSize: 20),
            
                    Spacer(),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
            
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1), // White border around the button
                            borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove, color: Colors.white, size: 14),
                            onPressed: () {
                              if (controller.quantity.value > 1) {
                                controller.quantity.value--;
                              }
                            },
                          ),
                        ),
            
                        12.sbw,
            
                        Obx(
                              () => MyText(
                              text: '${controller.quantity.value}',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
            
                        12.sbw,
            
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1), // White border around the button
                            borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white,size: 14),
                            onPressed: () {
                              controller.quantity.value++;
                            },
                          ),
                        ),
                      ],
                    ),
            
                  ],
                ),
            
                20.sbh,
            
                PrimaryButton(
                    color: R.theme.primary,
                    text: 'Choose a plan',
                    onPressed: () {
                      Get.to(CheckoutScreen(imageUrl: imageUrl, countryName: countryName));
                    }
                )
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}
