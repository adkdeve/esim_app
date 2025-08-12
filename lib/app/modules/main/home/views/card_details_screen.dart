import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/build_image.dart';
import '../../../../../common/widgets/custom_country_card.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../../common/widgets/smooth_rectangle_border.dart';
import '../../../../core/core.dart';
import '../controllers/home_controller.dart';

class CardDetailScreen extends GetView<HomeController>  {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: R.theme.white,
        title: MyText(text: 'Card Detail', fontSize: 20, textAlign: TextAlign.center, fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.arrow_back)
        ),
      ),
      body: Stack(
        children:[
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
                                      : R.theme.primary.withOpacity(.03),
                                  shape: SmoothRectangleBorder(
                                    smoothness: 1,
                                    borderRadius: BorderRadius.circular(
                                      AppConfig.defaultPadding,
                                    ),
                                    side: BorderSide(
                                      color: isSelected
                                          ? R.theme.primary
                                          : R.theme.grey,
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

                  Stack(
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
                                  child: Image.network(
                                    'https://flagcdn.com/w320/cn.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                10.sbw,

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    MyText(text: 'China', fontSize: 18, fontWeight: FontWeight.bold, color: R.theme.black,),

                                    MyText(text: 'eSIM', fontSize: 10, color: R.theme.grey),
                                  ],
                                ),

                                Spacer(),

                                buildImage('assets/images/ic_sim.png', width: 32, height: 26),
                              ],
                            ),

                            40.sbh,

                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Plan Benefits:',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
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

                                    MyText(text: 'Up to 5G speed', fontSize: 10, color: R.theme.grey),
                                  ],
                                ),

                                8.sbw,

                                Row(
                                  children: [

                                    Icon(Icons.calendar_month_outlined, size: 12, color: R.theme.grey),

                                    8.sbw,

                                    MyText(text: '7 days',fontSize: 10, color: R.theme.grey),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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

                  10.sbh,

                  Column(
                    children: controller.plans.map((plan) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedPlanIndex.value = plan['index'];
                          controller.quantity.value = 1;
                        },
                        child: CustomCard(
                          price: plan['price'],
                          calls: plan['calls'],
                          sms: plan['sms'],
                          data: plan['data'],
                          validity: plan['validity'],
                          index: plan['index'],
                        ),
                      );
                    }).toList(),
                  ),

                  150.sbh

                ],
              ),
            ),
          ),

          Positioned(
              bottom: 0,  // Stays at the bottom of the screen
              left: 0,
              right: 0,
              child: SubscriptionWidget()),
        ]
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final double price;
  final String calls;
  final String sms;
  final String data;
  final String validity;
  final int index;

  CustomCard({
    required this.price,
    required this.calls,
    required this.sms,
    required this.data,
    required this.validity,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      bool isSelected = controller.selectedPlanIndex.value == index;

      return GestureDetector(
        onTap: () {
          controller.selectedPlanIndex.value = index;
          controller.quantity.value = 1;
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: 12.radius,
            side: BorderSide(
              color: isSelected ? R.theme.black : R.theme.transparent,
              width: 1,
            ),
          ),
          margin: 5.all,
          color: isSelected ? R.theme.primary : R.theme.white,
          child: Padding(
            padding: 16.all,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: 12.radius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (bool? value) {
                          if (value != null && value) {
                            controller.selectedPlanIndex.value = index;
                          } else {
                            controller.selectedPlanIndex.value = -1;
                          }
                        },
                        checkColor: R.theme.grey,
                        activeColor: R.theme.white,
                      ),
                      MyText(
                        text: '\$${price.toStringAsFixed(2)}',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? R.theme.white : R.theme.black,
                      ),
                    ],
                  ),

                  8.sbh,

                  _buildDetailRow(
                    Icons.phone,
                    'Calls',
                    calls,
                    isSelected,
                  ),
                  _buildDetailRow(
                    Icons.message_outlined,
                    'SMS',
                    sms,
                    isSelected,
                  ),
                  _buildDetailRow(
                    Icons.wifi,
                    'Data',
                    data,
                    isSelected,
                  ),
                  _buildDetailRow(
                    Icons.calendar_month_outlined,
                    'Validity',
                    validity,
                    isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDetailRow(IconData icon, String iconText, String value, bool isSelected) {
    return Padding(
      padding: 4.vertical,
      child: Row(
        children: [

          Icon(
            icon,
            size: 20,
            color: isSelected ? R.theme.white : R.theme.black,
          ),

          8.sbw,

          MyText(
            text: iconText,
            fontSize: 14,
            color: isSelected ? R.theme.white : R.theme.black,
          ),

          Spacer(),

          MyText(
            text: '$value',
            fontSize: 14,
            color: isSelected ? R.theme.white : R.theme.black,
          ),
        ],
      ),
    );
  }
}

class SubscriptionWidget extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double totalPrice = 0;

      if (controller.selectedPlanIndex.value != -1) {
        var selectedPlan = controller.plans[controller.selectedPlanIndex.value];
        totalPrice = selectedPlan['price'] * controller.quantity.value;
      }

      var selectedPlan = controller.selectedPlanIndex.value != -1
          ? controller.plans[controller.selectedPlanIndex.value]
          : null;

      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: 16.all,
          decoration: BoxDecoration(
            color: R.theme.white,
            borderRadius: 12.radius,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if (controller.selectedPlanIndex.value != -1)
                Container(
                  margin: 10.all,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: R.theme.white,
                    border: Border.all(color: R.theme.black, width: 1),
                    borderRadius: 10.radius,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Expanded(
                        child: MyText(
                          text: '${selectedPlan!['validity']}, ${selectedPlan['sms']} SMS and phone calls and ${selectedPlan['data']}',
                          fontSize: 16,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (controller.quantity.value > 1) {
                                controller.quantity.value--;
                              }
                              },
                          ),

                          Text(
                            '${controller.quantity.value}',
                            style: TextStyle(fontSize: 16),
                          ),

                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              controller.quantity.value++;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              12.sbh,

              Container(
                width: double.infinity,
                padding: 12.vertical,
                decoration: BoxDecoration(
                  color: R.theme.primary,
                  borderRadius: 8.radius,
                ),
                child: Center(
                  child: MyText(
                    text: 'Checkout: \$${totalPrice.toStringAsFixed(2)} USD',
                    fontSize: 14,
                    color: R.theme.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
