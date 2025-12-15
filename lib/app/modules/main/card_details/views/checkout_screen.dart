import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import '../../../../../common/widgets/build_image.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../../common/widgets/primary_button.dart';
import '../controllers/checkout_screen_controller.dart'; // Import your new controller

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());
    // The Controller is already injected via GetX Binding or Get.put()
    // We access data using 'controller.variableName'

    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Checkout', fontSize: 20),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Background
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
                mainAxisSize: MainAxisSize.min,
                children: [

                  // --- TOP CARD ---
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: R.theme.white,
                      borderRadius: 20.radius,
                    ),
                    child: Stack(
                      children: [
                        // Background Pattern
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: 20.radius,
                            child: SvgPicture.asset(
                              'assets/icons/ic_credit_card_background.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Content
                        Padding(
                          padding: 16.all,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- Top Row (Image, Name, Icon) ---
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: 50.radius,
                                    child: buildImage(
                                        controller.imageUrl, // Access via Controller
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        context: context
                                    ),
                                  ),
                                  10.sbw,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: controller.countryName, // Access via Controller
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      MyText(text: 'Standard eSIM', fontSize: 10, color: Colors.grey),
                                    ],
                                  ),
                                  Spacer(),
                                  buildImage('assets/images/ic_sim.png', width: 32, height: 26, context: context),
                                ],
                              ),

                              // --- Price Section ---
                              Padding(
                                padding: const EdgeInsets.only(left: 40, top: 6),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                    color: R.theme.black,
                                    text: '\$${controller.totalPrice.toStringAsFixed(2)}', // Access via Controller
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Spacer(),

                              // --- Benefits Section ---
                              MyText(text: 'Plan Benefits:', fontSize: 10, fontWeight: FontWeight.bold, color: R.theme.black),
                              8.sbh,
                              Row(
                                children: [
                                  _buildBenefitItem(icon: 'assets/icons/ic_no_data.svg', text: 'Data only', context: context),
                                  8.sbw,
                                  _buildBenefitItem(icon: 'assets/icons/ic_speed.svg', text: 'Up to 5G', context: context),
                                  8.sbw,
                                  _buildBenefitItem(
                                      iconObj: Icons.calendar_month_outlined,
                                      text: '${controller.plan.validityDays} days', // Access via Controller
                                      context: context
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

                  // --- PRICE BREAKDOWN ---
                  Container(
                    padding: 16.all,
                    decoration: BoxDecoration(
                      borderRadius: 12.radius,
                      border: Border.all(color: R.theme.secondary, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: 'Price detail', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        16.sbh,

                        _buildPriceRow(
                            label: 'Plan (${controller.formattedDataUI})', // Access formatted getter
                            price: controller.plan.retailPrice
                        ),
                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Quantity', fontSize: 12),
                            Spacer(),
                            MyText(text: 'x ${controller.quantity}', fontSize: 12),
                          ],
                        ),

                        Divider(color: R.theme.grey.withOpacity(0.5)),
                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Total Amount', fontSize: 14, fontWeight: FontWeight.bold),
                            Spacer(),
                            MyText(
                                text: '\$${controller.totalPrice.toStringAsFixed(2)}',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: R.theme.primary
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox(
          height: 56,
          child: PrimaryButton(
              color: R.theme.primary,
              text: 'Pay \$${controller.totalPrice.toStringAsFixed(2)}',
              onPressed: () => controller.submitOrder() // Call Controller Action
          ),
        ),
      ),
    );
  }

  // Pure UI Helpers (Can stay in View)
  Widget _buildBenefitItem({String? icon, IconData? iconObj, required String text, required BuildContext context}) {
    return Row(
      children: [
        if (icon != null)
          buildImage(icon, width: 12, height: 12, color: R.theme.grey, context: context)
        else
          Icon(iconObj, size: 12, color: R.theme.grey),
        8.sbw,
        MyText(text: text, fontSize: 10, color: R.theme.grey),
      ],
    );
  }

  Widget _buildPriceRow({required String label, required double price}) {
    return Row(
      children: [
        MyText(text: label, fontSize: 12),
        Spacer(),
        MyText(text: '\$${price.toStringAsFixed(2)}', fontSize: 12)
      ],
    );
  }
}