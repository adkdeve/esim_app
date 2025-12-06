import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';

import '../../../../../common/widgets/build_image.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../../common/widgets/primary_button.dart';
import '../../../../../common/widgets/smooth_rectangle_border.dart';
import '../../../../data/models/esim_model.dart';
import '../controllers/card_details_controller.dart';
import 'checkout_screen.dart';

class CardDetailsView extends GetView<CardDetailsController> {
  const CardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Card Detail', fontSize: 20),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
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
          Obx(() {
            // CASE A: LOADING
            if (controller.isLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: R.theme.primary),
                    16.sbh,
                    MyText(text: "Fetching best plans...", fontSize: 14, color: R.theme.grey),
                  ],
                ),
              );
            }

            // CASE B: ERROR
            if (controller.errorMessage.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: 20.all,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                      10.sbh,
                      MyText(
                        text: controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        fontSize: 16,
                      ),
                      10.sbh,
                      ElevatedButton(
                          onPressed: () => controller.fetchPlans(controller.name),
                          child: Text("Retry")
                      )
                    ],
                  ),
                ),
              );
            }

            // CASE C: DATA LOADED (The main UI)
            return SingleChildScrollView(
              child: Padding(
                padding: 16.all,
                child: Column(
                  children: [

                    // --- Category (Validity Days) Selector ---
                    Padding(
                      padding: const EdgeInsets.only(left: AppConfig.defaultPadding),
                      child: SizedBox(
                        height: 35, // Increased height slightly to prevent clipping
                        child: Obx(() {
                          // This outer Obx listens to 'category' list changes (data loading)
                          if (controller.category.isEmpty) return SizedBox();

                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.category.length,
                            itemBuilder: (c, i) {

                              // --- FIX START ---
                              // Wrap the individual item in Obx.
                              // Now, when selectedCategoryIndex changes, only the specific items update their color.
                              return Obx(() {
                                var isSelected = i == controller.selectedCategoryIndex.value;

                                return GestureDetector(
                                  onTap: () => controller.filterPlansByIndex(i),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    decoration: ShapeDecoration(
                                      color: isSelected ? R.theme.primary : R.theme.secondary,
                                      shape: SmoothRectangleBorder(
                                        smoothness: 1,
                                        borderRadius: BorderRadius.circular(AppConfig.defaultPadding),
                                        side: BorderSide(
                                            width: 0.5,
                                            color: isSelected ? Colors.transparent : R.theme.grey
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: MyText(
                                        text: controller.category[i],
                                        fontSize: 12,
                                        color: isSelected ? R.theme.white : R.theme.color600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              });
                              // --- FIX END ---

                            },
                          );
                        }),
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

                    // --- Recommendation / Info Card ---
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: R.theme.white,
                        borderRadius: 20.radius,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: 20.radius,
                              child: SvgPicture.asset(
                                'assets/icons/ic_credit_card_background.svg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: 16.all,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: 50.radius,
                                      child: buildImage(
                                          controller.imageUrl,
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
                                          text: controller.name,
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 40, top: 6),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child:  MyText(
                                      color: R.theme.black,
                                      text: controller.priceRange, // Dynamic Price Range
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                MyText(text: 'Plan Benefits:', fontSize: 10, fontWeight: FontWeight.bold, color: R.theme.black),
                                8.sbh,
                                Row(
                                  children: [
                                    _buildBenefitItem(icon: 'assets/icons/ic_no_data.svg', text: 'Data only', context: context),
                                    8.sbw,
                                    _buildBenefitItem(icon: 'assets/icons/ic_speed.svg', text: 'Up to 5G', context: context),
                                    8.sbw,
                                    // Dynamic validity based on selection
                                    Obx(() {
                                      final plan = controller.recommendedPlan;
                                      return _buildBenefitItem(
                                          iconObj: Icons.calendar_month_outlined,
                                          text: plan != null ? '${plan.validityDays} days' : '--',
                                          context: context
                                      );
                                    }),
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
                      child: Obx(() => MyText(
                        text: '${controller.displayedPlans.length} Available Plans',
                        fontSize: 18,
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.w700,
                      )),
                    ),

                    20.sbh,

                    // --- Plans List ---
                    Obx(() {
                      if (controller.displayedPlans.isEmpty) {
                        return Center(child: MyText(text: "No plans found for this category", fontSize: null,));
                      }
                      return Column(
                        children: List.generate(controller.displayedPlans.length, (index) {
                          EsimProduct plan = controller.displayedPlans[index];
                          return GestureDetector(
                            onTap: () => controller.selectPlan(index),
                            child: Container(
                              color: Colors.transparent, // expand tap area
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      MyText(
                                        text: controller.formatData(plan.dataQuotaMb),
                                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,
                                      ),
                                      10.sbw,
                                      MyText(
                                        text: '${plan.validityDays} Days',
                                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,
                                      ),
                                      Spacer(),
                                      MyText(
                                        text: '\$${plan.retailPrice.toStringAsFixed(2)}',
                                        fontSize: 16, fontWeight: FontWeight.w500, color: R.theme.primary,
                                      ),
                                      10.sbw,
                                      Obx(() => Radio<int>(
                                        value: index,
                                        groupValue: controller.selectedPlanIndex.value,
                                        onChanged: (int? value) => controller.selectPlan(value!),
                                        activeColor: R.theme.white,
                                        fillColor: MaterialStateProperty.all(R.theme.white),
                                      )),
                                    ],
                                  ),
                                  Divider(color: R.theme.grey.withOpacity(0.5)),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Obx(() {
        if (controller.selectedPlanIndex.value == -1) return const SizedBox.shrink();

        return SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 130,
            decoration: BoxDecoration(color: R.theme.backgroundClr),
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    MyText(text: controller.selectedPlanDescription, fontSize: 20),
                  ],
                ),
                20.sbh,
                PrimaryButton(
                    color: R.theme.primary,
                    text: 'Pay \$${controller.totalPrice.toStringAsFixed(2)}', // Show total price on button
                    onPressed: () {
                      // 1. Get the selected plan object
                      final selectedPlan = controller.displayedPlans[controller.selectedPlanIndex.value];

                      // 2. Navigate and pass data as arguments
                      Get.to(
                              () => const CheckoutScreen(),
                          arguments: {
                            'plan': selectedPlan,              // Contains uid, price, data, etc.
                            'quantity': controller.quantity.value,
                            'name': controller.name,
                            'imageUrl': controller.imageUrl,
                          }
                      );
                    }
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  // Helper for Benefit Items
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

  // Helper for Qty Buttons
  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 30, height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 14),
        onPressed: onTap,
        padding: EdgeInsets.zero,
      ),
    );
  }
}