import 'package:flutter/material.dart';
import 'package:pcom_app/common/widgets/build_image.dart';
import '../../app/core/core.dart';
import 'my_text.dart';

class CustomCard extends StatelessWidget {
  final String countryName;
  final String flagAsset;

  CustomCard({required this.countryName, required this.flagAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: R.theme.white,
        borderRadius: 15.radius,
        boxShadow: [
          BoxShadow(
            color: R.theme.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [

          Positioned(
            left: 12,
            top: 12,
            child: MyText(
              text: countryName,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: R.theme.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Positioned(
            right: -15,
            bottom: -20,
            child: ClipOval(
              child: Align(
                alignment: Alignment.bottomRight,
                child: buildImage(
                  flagAsset,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
