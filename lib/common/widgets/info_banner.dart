import 'package:flutter/material.dart';
import 'package:pcom_app/app/core/core.dart';

import 'my_text.dart';

class InfoBanner extends StatelessWidget {
  final String message;

  const InfoBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xff0E173A54),
        borderRadius: 12.radius,
      ),
      child: Row(
        children: [

          const Icon(
            Icons.info_outline,
            color: Color(0xFF0052B4),
            size: 22,
          ),

          18.sbw,

          Expanded(
            child: MyText(
              text: message,
              color: Color(0xFF0052B4),
              fontSize: 15,
              fontWeight: FontWeight.w500,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
