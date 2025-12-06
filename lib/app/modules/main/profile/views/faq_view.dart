import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../core/core.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'FAQ\'s', fontSize: 20),
        centerTitle: true,
      ),
      body: SizedBox.expand(
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

            SingleChildScrollView(
              child: Padding(
                padding: 16.all,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const FaqsItems(
                      initiallyExpanded: true,
                      question: 'What is an eSIM and how can you benefit from Wilixify?',
                      answer:
                      'An eSIM (embedded SIM) is a digital SIM card that is directly installed on your smartphone or other mobile devices. It’s an alternative to the physical SIM card you’re used to.\n\nWith WilixifySoft, you can:\n• Activate your eSIM instantly.\n• Enjoy affordable data plans worldwide.\n• Avoid roaming fees and plastic waste.\n\nStay connected, hassle-free with WilixifySoft.',
                    ),

                    const FaqsItems(
                      question: 'How to activate WilixifySoft eSIM?',
                      answer:
                      'Installation By SCAN:\n1. Go to “Settings” > “Connections”\n2. Go to “SIM Manager”\n3. Tap on “Add eSIM”\n4. Tap on Scan the QR Code\n5. Add and name your eSIM\n\nFor Manual Installation:\n1. Go to “Settings” > “Connections”\n2. Go to “SIM Manager”\n3. Tap on “Add eSIM”\n4. Tap on “Enter Activation Code” Below\n5. Enter the “SM-DP Address” by copying and pasting it\n6. Enter Activation Code\n7. Name your eSIM\n\nActivation Process:\nOnce arrived at your destination, please use the following steps:\n1. Select your WilixifySoft in “Mobile data”\n2. Activate the “Data Roaming”\n\nOnce your eSIM is activated, you can enjoy the benefits of high-speed internet.',
                    ),

                    const FaqsItems(
                      question: 'Is my eSIM activated instantly after purchase?',
                      answer:
                      'No, the eSIM does not activate immediately after purchase. You can keep it for up to 30 days before activating it at your convenience.\n\nOnce activated, the eSIM can be used as usual.',
                    ),

                    const FaqsItems(
                      question: 'Why is WilixifySoft the best eSIM provider?',
                      answer:
                      'At WilixifySoft, we’re dedicated to making your eSIM journey seamless and cost-effective. Here’s what sets us apart:\n\n• Affordable Pricing: Enjoy global data plans at unbeatable rates.\n• User-Friendly Setup: Activating your eSIM with Simbye is simple and hassle-free.\n• Instant Activation: Begin using your eSIM within minutes of purchase.\n• Customizable Plans: Select from a range of plans designed to suit your travel or local connectivity needs.',
                    ),

                    const FaqsItems(
                      question: 'Can I use my SIM card and WilixifySoft eSIM at the same time?',
                      answer:
                      'Yes, if you use an Apple device, you can use your SIM card and your Simbye eSIM simultaneously:\n\n• SIM Card: Use it for phone calls and SMS.\n• WilixifySoft eSIM: Use it for mobile data.\n\nHowever, please note that your carrier may charge roaming fees if your SIM card remains active for receiving or sending calls and SMS while you are abroad. To avoid unexpected charges, consider disabling data roaming for your physical SIM.',
                    ),

                    const FaqsItems(
                      question: 'Should I remove my eSIM after using up its data?',
                      answer:
                      'No, it’s not mandatory to delete your eSIM after its data is used up. If you intend to recharge or reuse the same eSIM in the future, it’s better to keep it on your device. However, if you no longer need it or wish to free up space for a new eSIM, you can safely delete it from your device settings.\n\nPlease note that WilixifySoft offers eSIM data top-up options, allowing you to continue enjoying uninterrupted connectivity without replacing your eSIM.',
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class ShowHideBtn extends StatelessWidget {
  const ShowHideBtn({
    super.key,
    required this.isShow,
    this.isBlack = false,
    required this.onTap,
  });
  final bool isShow;
  final bool isBlack;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: onTap,
        child: Icon(
          color: R.theme.primary,
          isShow
              ? Icons.minimize
              : Icons.add,
        ),
      ),
    );
  }
}

class FaqsItems extends StatefulWidget {
  const FaqsItems({
    super.key,
    required this.question,
    required this.answer,
    this.initiallyExpanded = false,
  });
  final String question;
  final String answer;
  final bool initiallyExpanded;

  @override
  State<FaqsItems> createState() => _FaqsItemsState();
}

class _FaqsItemsState extends State<FaqsItems> {
  var isShow = false;

  @override
  void initState() {
    super.initState();
    isShow = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.sbh,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: MyText(
                text: widget.question,
                fontSize: 16,
                softWrap: true,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.28,
                color: R.theme.white,
              ),
            ),
            (16 * 2).sbw,
            ShowHideBtn(
              isShow: isShow,
              onTap: () {
                setState(() {
                  isShow = !isShow;
                });
              },
            ),
          ],
        ),
        (16 / 4).sbh,
        Visibility(
          visible: isShow,
          child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF23243A), // Top left (dark navy blue)
                    Color(0xFF2D2F42), // Bottom right (lighter navy)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            child: MyText(
              text: widget.answer,
              fontSize: 16,
              softWrap: true,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.28,
              textAlign: TextAlign.start,
              color: R.theme.white.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}