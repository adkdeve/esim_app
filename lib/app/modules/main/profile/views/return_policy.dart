import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/my_text.dart';

import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ReturnPolicy extends StatelessWidget {
  const ReturnPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Return Policy", fontSize: 20),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // --- 1. Icon List (Top Section) ---
                  Row(
                    children: [
                      const Icon(Icons.notifications_none, size: 16, color: Colors.grey), // Bell Icon
                      8.sbw,
                      MyText(text: "Last Update: Aug 19, 2025", fontSize: 14, color: Colors.grey),
                    ],
                  ),

                  8.sbh,

                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey), // Calendar Icon
                      8.sbw,
                      MyText(text: "Effective Date: Aug 20, 2025", fontSize: 14, color: Colors.grey),
                    ],
                  ),

                  20.sbh,

                  // --- 2. Paragraph 1 (Refund Guarantee) ---
                  MyText(
                    text: "If your data plan doesn’t work or can’t be installed on your device, we will provide a 100% refund, no questions asked. This guarantee applies only to faulty data plans with no data usage.",
                    fontSize: 14,
                    height: 1.5,
                    textAlign: TextAlign.start,
                    softWrap: true,
                    color: R.theme.white, // Ensure readable color
                  ),

                  16.sbh,

                  // --- 3. Paragraph 2 (Usage Limit) ---
                  MyText(
                    text: "Any Prepaid eSIM plan which consumes more than 10% of the plan’s fixed data allowance, or any Unlimited eSIM plan which consumes more than 1 GB of data over any period of time, will be deemed to have been successfully provisioned and activated on the network, and will be non-refundable.",
                    fontSize: 14,
                    height: 1.5,
                    textAlign: TextAlign.start,
                    softWrap: true,
                    color: R.theme.white,
                  ),

                  16.sbh,

                  // --- 4. Paragraph 3 (MSA Link) ---
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.white, fontFamily: 'GoogleFonts.poppins().fontFamily'), // Match your app font
                      children: [
                        const TextSpan(text: "Additional Terms & Conditions apply, which can be found in the "),
                        TextSpan(
                          text: "Master Service Agreement",
                          style: TextStyle(
                            color: R.theme.primary, // Link Color
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final Uri url = Uri.parse('https://wilixifysoft.com/master-service-agreement/');
                              if (!await launchUrl(url)) {
                                debugPrint('Could not launch $url');
                              }
                            },
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),

                  16.sbh,

                  // --- 5. Paragraph 4 (Strong/Bold + Link) ---
                  RichText(
                    text: TextSpan(
                      // HTML <strong> tag means FontWeight.bold
                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.white, fontWeight: FontWeight.bold),
                      children: [
                        const TextSpan(text: "To request account cancellation or get help with service issues, please "),
                        TextSpan(
                          text: "Submit a request!",
                          style: TextStyle(
                            color: R.theme.primary, // Link Color
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final Uri url = Uri.parse('https://wilixifysoft.com/conat-us/');
                              if (!await launchUrl(url)) {
                                debugPrint('Could not launch $url');
                              }
                            },
                        ),
                      ],
                    ),
                  ),

                  16.sbh,

                  // --- 6. Paragraph 5 (Strong/Bold) ---
                  MyText(
                    text: "Please do not mark your request Solved after viewing this article. We need to manually review each cancellation/refund request.",
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.bold, // HTML <strong> tag
                    textAlign: TextAlign.start,
                    softWrap: true,
                    color: Colors.white,
                  ),

                  30.sbh,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}