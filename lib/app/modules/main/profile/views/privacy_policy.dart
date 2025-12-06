import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/my_text.dart';

// class PrivacyView extends StatelessWidget {
//   const PrivacyView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: MyText(text: "Privacy Policy", fontSize: 20),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: SvgPicture.asset(
//               "assets/images/background.svg",
//               fit: BoxFit.fill,
//               alignment: Alignment.bottomCenter,
//               allowDrawingOutsideViewBox: true,
//             ),
//           ),
//
//           SingleChildScrollView(
//             child: Padding(
//               padding: 16.all,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   MyText(text: "Condition & Attending", fontSize: 18, textAlign: TextAlign.start),
//
//                   10.sbh,
//
//                   MyText(
//                     text: "At enim hic etiam dolore. Dulce amarum, leve asperum, prope longe, stare movere, quadratum rotundum. At certe gravius. Nullus est igitur cuiusquam dies natalis. Paulum, cum regem Persem captum adduceret, eodem flumine invectio?\n\n"
//                         "\n\n"
//                         "Quare hoc videndum est, possitne nobis hoc ratio philosophorum dare.\n\n"
//                         "Sed finge non solum callidum eum, qui aliquid improbe faciat, verum etiam praepotentem, ut M.\n\n"
//                         "Est autem officium, quod ita factum est, ut eius facti probabilis ratio reddi possit.\n\n",
//                     fontSize: 14,
//                     softWrap: true,
//                     textAlign: TextAlign.start,
//                     height: 1.3,
//                   ),
//
//                   20.sbh,
//
//                   MyText(text: "Terms & Use", fontSize: 18, textAlign: TextAlign.start),
//
//                   10.sbh,
//
//                   MyText(
//                     text: "Ut proverbia non nulla veriora sint quam vestra dogmata. Tamen aberramus a proposito, et, ne longius, prorsus, inquam, Piso, si ista mala sunt, placet. Omnes enim iucundum motum, quo sensus hilaretur. Cum id fugiunt, re eadem defendunt, quae Peripatetici, verba. Quibusnam praeteritis? Portenta haec esse dicit, quidem hactenus; Si id dicis, vicimus. Qui ita affectus, beatum esse numquam probabis; Igitur neque stultorum quisquam beatus neque sapientium non beatus.\n\n"
//                         "\n\n"
//                         "Dicam, inquam, et quidem discendi causa magis, quam quo te aut Epicurum reprehensum velim. Dolor ergo, id est summum malum, metuetur semper, etiamsi non ader.",
//                     fontSize: 14,
//                     softWrap: true,
//                     textAlign: TextAlign.start,
//                     height: 1.3,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Privacy Policy", fontSize: 20),
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
                  // --- Meta Data ---
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: R.theme.secondary.withOpacity(0.1), // Assuming you have a secondary color, or use Colors.grey[200]
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.notifications_none, size: 16, color: Colors.grey),
                            8.sbw,
                            Expanded(child: MyText(text: "Last Update: Aug 19, 2025", fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        4.sbh,
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                            8.sbw,
                            Expanded(child: MyText(text: "Effective Date: Aug 20, 2025", fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  20.sbh,

                  // --- Intro ---
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile respects your privacy and is dedicated to protecting the Personal Data it collects. The purpose of this Privacy Policy (“Policy”) is to inform you about the privacy of your data while using a Service.\n\n"
                          "By using or continuing to use a Service, including without limitation visiting WILIXIFYeSIM Mobile’s website or otherwise providing your Personal Data to WILIXIFYeSIM Mobile, you accept and consent to the rights, obligations, and practices described in this Policy."
                  ),

                  20.sbh,

                  // --- User Choice ---
                  _buildSectionTitle("User Choice"),
                  10.sbh,
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile is committed to the principles of user consent and choice and encourages you to determine your preferred experience when interacting with WILIXIFYeSIM Mobile. To this end, you may limit, restrict, or deny WILIXIFYeSIM Mobile’s ability to share your Personal Data with third parties, or to use your Personal Data for a purpose that is materially different from the purpose for which it was originally collected or authorized by you, subject to applicable law. In order to exercise your right to choose, please submit a request via our Support Center."
                  ),

                  20.sbh,

                  // --- Notices ---
                  _buildSectionTitle("Notices"),
                  10.sbh,
                  _buildBodyText(
                      "Some jurisdictions require WILIXIFYeSIM Mobile to supply statutory notices regarding your Personal Data. These notices can be found on our legal page, including WILIXIFYeSIM Mobile’s GDPR, and CCPA specific notices."
                  ),

                  20.sbh,

                  // --- Additional Terms ---
                  _buildSectionTitle("Additional Terms"),
                  10.sbh,
                  _buildSubHeading("Verification"),
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile utilizes the self-assessment approach to assure its compliance with its Privacy Policy. WILIXIFYeSIM Mobile regularly verifies that the Policy is accurate, comprehensive, prominently displayed, completely implemented, and in conformity with applicable international law. WILIXIFYeSIM Mobile conducts its self-assessment on an annual basis to ensure that all relevant privacy practices are being followed."
                  ),
                  10.sbh,
                  _buildSubHeading("Applicability"),
                  _buildBodyText(
                      "This Policy applies to you and your Covered Users with respect to the Services. You shall be responsible for (i) informing your other Covered Users, if any, of the existence of this Policy, as well as any amendments, updates, or modifications made to this Policy and (ii) agreeing to this Policy, as amended, updated or modified from time to time, on behalf of all Covered Users."
                  ),

                  20.sbh,

                  // --- Types of Collected Data ---
                  _buildSectionTitle("Types of Collected Data"),
                  10.sbh,
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile considers any information that can be used to directly or indirectly identify you to be “Personal Data,” including without limitation, Personal Data that is accessed, collected, maintained, transmitted, and/or used by WILIXIFYeSIM Mobile in the normal course of our business. Please note, in the absence of any notice to the contrary, you expressly grant WILIXIFYeSIM Mobile permission to share your Personal Data at WILIXIFYeSIM Mobile’s discretion."
                  ),

                  20.sbh,

                  // --- Methods of Data Collection ---
                  _buildSectionTitle("Methods of Data Collection"),
                  10.sbh,
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile uses cookies and similar technologies to enhance your experience and interactions with the Services. These tools can be stored locally, and are used by WILIXIFYeSIM Mobile and our Representatives for operationally necessary purposes, as well as functional, performance, analytical, and marketing reasons. WILIXIFYeSIM Mobile also uses third party tools, such as Google Analytics, to enhance our provision of the Services."
                  ),

                  20.sbh,

                  // --- Purposes of Collected Data ---
                  _buildSectionTitle("Purposes of Collected Data"),
                  10.sbh,

                  _buildSubHeading("For Customers"),
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile may use Personal Data to process your service requests, handle orders, deliver products and services, process payments, communicate with you about orders, provide access to secure areas of WILIXIFYeSIM Mobile’s website, and to enable WILIXIFYeSIM Mobile to review, develop, and continually improve the products, services, and offers that it provides."
                  ),

                  10.sbh,
                  _buildSubHeading("For Visitors"),
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile may use Personal Data to send information about WILIXIFYeSIM Mobile to visitors and to contact such visitors. WILIXIFYeSIM Mobile also uses the information that it collects to improve the content of our website, enhance user experiences, and as training aids for our employees."
                  ),

                  10.sbh,
                  _buildSubHeading("For Payment Information"),
                  _buildBodyText(
                      "WILIXIFYeSIM may ask Account holders to enter credit card or account information in order to process orders for Services. Financial information provided via our website is transferred to a WILIXIFYeSIM Mobile Third Party Service Provider for payment processing."
                  ),

                  10.sbh,
                  _buildSubHeading("For Use Information"),
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile uses website use information to measure interest in and develop its web pages and marketing plans. In addition, WILIXIFYeSIM Mobile uses:\n\n"
                          "• IP addresses to help diagnose problems with its servers, and to administer its website;\n\n"
                          "• Cookies and other tools to help it recognize users as unique when they return to WILIXIFYeSIM Mobile’s website;\n\n"
                          "• Web beacons to count the number of times that its advertisements and web-based email content are viewed."
                  ),

                  10.sbh,
                  _buildSubHeading("For Support Information"),
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile uses information that you provide to it via telephone calls, chat, email, web forms, and other communications to correspond with you about services you may be interested in purchasing. Your telephone calls may be recorded for training and operational purposes."
                  ),

                  20.sbh,

                  // --- Disclosure ---
                  _buildSectionTitle("Disclosure to Regulatory Agencies and other Third Parties"),
                  10.sbh,
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile transfers Personal Data to third parties, including without limitation, law enforcement agencies and consumer reporting agencies, in the normal course of business, subject to service of lawful process or your written consent. Disclosure may include, but is not limited to, exchanging information with other companies and organizations for the purposes of regulatory auditing, fraud protection and credit risk reduction."
                  ),

                  20.sbh,

                  // --- Access to Personal Data ---
                  _buildSectionTitle("Access to Personal Data"),
                  10.sbh,
                  _buildBodyText(
                      "You control access to Personal Data maintained or stored by you via WILIXIFYeSIM Mobile’s web-based interface for account management. You may update your information at any time. You may cancel your account at any time and may request that your personal information be deleted from WILIXIFYeSIM Mobile’s databases, with certain exceptions (e.g., logs, fraud cases, TOS violations). Upon request, WILIXIFYeSIM Mobile will grant you reasonable access to Personal Data maintained about you."
                  ),

                  20.sbh,

                  // --- Sensitive Information ---
                  _buildSectionTitle("Sensitive Information"),
                  10.sbh,
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile will not intentionally collect or maintain, and requests that you do not provide, any information regarding your medical or health condition, race or ethnic origin, political opinions, religious or philosophical beliefs, or other sensitive information."
                  ),

                  20.sbh,

                  // --- Third Party Transfers ---
                  _buildSectionTitle("Third Party Transfers of Data"),
                  10.sbh,
                  _buildBodyText(
                      "WILIXIFYeSIM Mobile may transfer Personal Data to third parties acting on our behalf when operationally necessary to provide the Services."
                  ),

                  20.sbh,

                  // --- Children ---
                  _buildSectionTitle("Children’s Online Privacy Protection"),
                  10.sbh,
                  _buildBodyText(
                      "The services are not designed for or directed to children under thirteen (13) years of age and WILIXIFYeSIM Mobile will not intentionally collect or maintain information about anyone under thirteen (13) years of age."
                  ),

                  20.sbh,

                  // --- Enforcement ---
                  _buildSectionTitle("Enforcement"),
                  10.sbh,
                  _buildBodyText(
                      "If you believe your Personal Data has been used in a way that is not consistent with this Policy, please contact our custodian of records via email or by writing to us at: Custodian of Records, WILIXIFYeSIM Virtual, Inc., 8 The Green Ste 13521, Dover DE 19901."
                  ),

                  20.sbh,

                  // --- Dispute Resolution ---
                  _buildSectionTitle("Dispute Resolution"),
                  10.sbh,
                  _buildBodyText(
                      "Please direct any complaints regarding this Policy by submitting a request via our Support Center. We will attempt to resolve any such complaints in a reasonably timely manner and in accordance with this policy."
                  ),

                  20.sbh,

                  // --- Changes ---
                  _buildSectionTitle("Changes"),
                  10.sbh,
                  _buildBodyText(
                      "Amendments to this Policy may be made at any time and you should check back frequently for any changes. WILIXIFYeSIM Mobile shall have the right and ability to amend this Policy at WILIXIFYeSIM Mobile’s sole and absolute discretion."
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

  // Helper method for Section Titles (Bold, Larger)
  Widget _buildSectionTitle(String text) {
    return MyText(
      text: text,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      textAlign: TextAlign.start,
      color: Colors.white, // Adjust color as per theme
    );
  }

  // Helper method for Subheadings (Italic or semi-bold)
  Widget _buildSubHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: MyText(
        text: text,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.start,
      ),
    );
  }

  // Helper method for Body Text (Regular, readable height)
  Widget _buildBodyText(String text) {
    return MyText(
      text: text,
      fontSize: 14,
      softWrap: true,
      textAlign: TextAlign.start,
      height: 1.5, // Good line height for readability
      color: Colors.white70, // Slightly softer black for reading
    );
  }
}