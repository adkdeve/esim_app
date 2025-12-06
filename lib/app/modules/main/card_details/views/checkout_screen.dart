import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import '../../../../../common/widgets/build_image.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../../common/widgets/primary_button.dart';
import '../../../../data/models/esim_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. RETRIEVE ARGUMENTS
    final args = Get.arguments as Map<String, dynamic>;

    final EsimProduct plan = args['plan']; // Contains plan.uid (The ID you wanted)
    final int quantity = args['quantity'];
    final String name = args['name'];
    final String imageUrl = args['imageUrl'];

    // 2. CALCULATE TOTAL LOCALLY
    final double total = plan.retailPrice * quantity;
    final String dataAmount = _formatData(plan.dataQuotaMb);

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
                    height: 140, // Matched height to CardDetailsView
                    decoration: BoxDecoration(
                      color: R.theme.white,
                      borderRadius: 20.radius,
                    ),
                    child: Stack(
                      children: [
                        // 1. Background Pattern
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: 20.radius,
                            child: SvgPicture.asset(
                              'assets/icons/ic_credit_card_background.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // 2. Content
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
                                        imageUrl,
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
                                        text: name,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      // Matched style to "Standard eSIM" instead of ID for consistency
                                      MyText(text: 'Standard eSIM', fontSize: 10, color: Colors.grey),
                                    ],
                                  ),
                                  Spacer(),
                                  buildImage('assets/images/ic_sim.png', width: 32, height: 26, context: context),
                                ],
                              ),

                              // --- Price Section (Single Total) ---
                              Padding(
                                padding: const EdgeInsets.only(left: 40, top: 6),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                    color: R.theme.black,
                                    text: '\$${total.toStringAsFixed(2)}', // Showing specific total
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
                                  // Use the specific 'plan' object for validity
                                  _buildBenefitItem(
                                      iconObj: Icons.calendar_month_outlined,
                                      text: '${plan.validityDays} days',
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

                        _buildPriceRow(label: 'Plan ($dataAmount)', price: plan.retailPrice),
                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Quantity', fontSize: 12),
                            Spacer(),
                            MyText(text: 'x $quantity', fontSize: 12),
                          ],
                        ),

                        Divider(color: R.theme.grey.withOpacity(0.5)),
                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Total Amount', fontSize: 14, fontWeight: FontWeight.bold),
                            Spacer(),
                            MyText(text: '\$${total.toStringAsFixed(2)}', fontSize: 14, fontWeight: FontWeight.bold, color: R.theme.primary)
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
              text: 'Pay \$${total.toStringAsFixed(2)}',
              onPressed: () {
                // ACCESS THE ID HERE FOR API SUBMISSION
                print("Submitting Order for Plan ID: ${plan.uid}");
                print("Total: $total");
              }),
        ),
      ),
    );
  }

  String _formatData(int mb) {
    if (mb >= 1024) return "${(mb / 1024).toStringAsFixed(0)} GB";
    return "$mb MB";
  }

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
