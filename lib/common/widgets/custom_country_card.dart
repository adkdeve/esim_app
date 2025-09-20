import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../app/core/core.dart';
import 'circle_item.dart';

class CustomCard extends StatelessWidget {
  final String countryName;
  final String imageUrl;
  final double imageSize;
  final double textSize;
  final VoidCallback? onTap;


  const CustomCard({super.key,
    required this.countryName,
    required this.imageUrl,
    required this.imageSize,
    required this.textSize,
    this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: 14.all,
          height: 110,
          decoration: BoxDecoration(
              color: R.theme.backgroundClr,
              borderRadius: 15.radius,
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA7B6DF),
                    Color(0xFF080F21),
                    Color(0xFF080F21),
                    Color(0xFF96A2C8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                width: 2,
              ),
            ),
          child: CircleItem(name: countryName, imageUrl: imageUrl, imageSize: imageSize, textSize: textSize)
        ),
      ),
    );
  }
}


// class CustomCard extends StatelessWidget {
//   final String countryName;
//   final String flagAsset;
//   final String plansDescription;
//   final String priceLabel;
//   final String priceText;
//
//   const CustomCard({super.key,
//     required this.countryName,
//     required this.flagAsset,
//     required this.plansDescription,
//     required this.priceLabel,
//     required this.priceText,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
//       child: Container(
//         decoration: BoxDecoration(
//           color: R.theme.backgroundClr,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//             bottomLeft: Radius.circular(15),
//           ),
//           border: const GradientBoxBorder(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFFA7B6DF),
//                 Color(0xFF080F21),
//                 Color(0xFF080F21),
//                 Color(0xFF96A2C8),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             width: 2,
//           ),
//         ),
//         child: Stack(
//           children: [
//
//             Positioned(
//               left: 12,
//               top: 12,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//
//                   MyText(
//                     text: countryName,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: R.theme.white,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//
//                   5.sbh,
//
//                   Container(
//                     constraints: BoxConstraints(maxWidth: 150),
//                     child: MyText(
//                       text: plansDescription,
//                       fontSize: 12,
//                       softWrap: true,
//                       opacity: 0.5,
//                       textAlign: TextAlign.start,
//                       color: R.theme.white.withOpacity(0.7),
//                     ),
//                   ),
//
//                   12.sbh,
//
//                   MyText(
//                     text: priceLabel,
//                     fontSize: 10,
//                     color: R.theme.white.withOpacity(0.7),
//                   ),
//
//                   2.sbh,
//
//                   MyText(
//                     text: priceText,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                     color: R.theme.white,
//                   ),
//                 ],
//               ),
//             ),
//
//             Positioned(
//               right: -15,
//               bottom: -20,
//               child: ClipOval(
//
//                 child: Align(
//
//                   alignment: Alignment.bottomRight,
//                   child: buildImage(
//
//                     flagAsset,
//                     width: 70,
//                     height: 70,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
