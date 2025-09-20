import 'package:flutter/material.dart';
import 'package:pcom_app/app/core/core.dart';
import 'my_text.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    this.onGotIt,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback? onGotIt;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: 12.radius,
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A3B8F),
              Color(0xFF071B47),
            ],
          ),
        ),
        child: Row(
          children: [

            SizedBox(
              width: 132,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 0),
                  child: Image.asset(
                    'assets/images/ic_reminder_person.png',
                    height: 140,
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),

            12.sbw,

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  MyText(
                    text: title,
                    color: R.theme.white,
                    fontSize: 20,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),

                  6.sbh,

                  MyText(
                    text: subtitle,
                    color: R.theme.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),

                  12.sbh,

                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 100,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: onGotIt,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: R.theme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: 12.radius,
                          ),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                        ),
                        child: MyText(
                          text: 'Got it!',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          height: 0.75,
                          color: R.theme.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            16.sbw,
          ],
        ),
      ),
    );
  }
}

