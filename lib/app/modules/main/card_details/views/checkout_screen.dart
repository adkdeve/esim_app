import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import '../../../../../common/widgets/build_image.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../../common/widgets/primary_button.dart';
import '../controllers/card_details_controller.dart';

class CheckoutScreen extends GetView<CardDetailsController> {
  const CheckoutScreen({super.key, required this.countryName, required this.imageUrl });
  final String? imageUrl;
  final String? countryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Checkout', fontSize: 20),
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


          SingleChildScrollView(
            child: Padding(
              padding: 16.all,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

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

                  Container(
                    padding: 16.all,
                    decoration: BoxDecoration(
                      borderRadius: 12.radius,
                      border: Border.all(color: R.theme.secondary, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MyText(
                          text: 'Price detail',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),

                        16.sbh,

                        Row(
                          children: [
                            MyText(text: 'No share data', fontSize: 12),
                            Spacer(),
                            MyText(text: '\$2.11', fontSize: 12)
                          ],
                        ),

                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Up to 5G speed', fontSize: 12),
                            Spacer(),
                            MyText(text: '\$0.99', fontSize: 12)
                          ],
                        ),

                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Services fee', fontSize: 12),
                            Spacer(),
                            MyText(text: '\$0.90', fontSize: 12)
                          ],
                        ),

                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Tax', fontSize: 12),
                            Spacer(),
                            MyText(text: '\$0.00', fontSize: 12)
                          ],
                        ),

                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Subtotal', fontSize: 12),
                            Spacer(),
                            MyText(text: '\$4.00', fontSize: 12)
                          ],
                        ),

                        8.sbh,

                        Row(
                          children: [
                            MyText(text: 'Total', fontSize: 12),
                            Spacer(),
                            MyText(text: '\$4.00', fontSize: 12)
                          ],
                        ),

                      ],
                    ),
                  ),

                  8.sbh,

                  Container(
                    padding: 16.all,
                    decoration: BoxDecoration(
                      borderRadius: 12.radius,
                      border: Border.all(color: R.theme.secondary, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            Container(
                                padding: 1.5.all,
                                decoration: BoxDecoration(
                                  color: R.theme.white,
                                  borderRadius: 4.radius,
                                ),
                                child: SvgPicture.asset("assets/icons/ic_credit_icon.svg",width: 20, height: 20)
                            ),

                            4.sbw,

                            MyText(text: "Payment method", fontSize: 16),

                            Spacer(),

                            IconButton(onPressed: () => {}, icon: Icon(Icons.edit), iconSize: 20)

                          ],
                        ),

                        MyText(
                          text: "You can choose or change the payment method to complete your order.",
                          fontSize: 12,
                          softWrap: true,
                          textAlign: TextAlign.start,
                        )

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
          child: Container(
            child: PrimaryButton(
                color: R.theme.primary,
                text: 'Continue to payment',
                onPressed: () {

                }),
          ),
        ),
      ),
    );
  }
}
