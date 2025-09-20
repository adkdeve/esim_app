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
                      question: 'What is Rise Real Estate?',
                      answer:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut. aliquip ex ea commodo consequat. Duis aute irure dolor.',
                    ),

                    const FaqsItems(
                      question: 'Why choose buy in Rise?',
                      answer:
                      '"You can add a friend either by searching their name in the search bar or by letting them sharing their profile for you from the profile page on yapo."',
                    ),

                    const FaqsItems(
                      question: 'What is Safar?',
                      answer:
                      '"You can add a friend either by searching their name in the search bar or by letting them sharing their profile for you from the profile page on yapo."',
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
  });
  final String question;
  final String answer;

  @override
  State<FaqsItems> createState() => _FaqsItemsState();
}

class _FaqsItemsState extends State<FaqsItems> {
  var isShow = false;
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