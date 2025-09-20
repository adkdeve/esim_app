import 'package:flutter/material.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/build_image.dart';
import 'my_text.dart';

class CircleItem extends StatelessWidget {
  const CircleItem({required this.name, required this.imageUrl, required this.imageSize, required this.textSize});

  final String name;
  final String imageUrl;
  final double textSize;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          ClipOval(
            child: buildImage(
              imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),
          10.sbh,
          MyText(
            text: name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            color: R.theme.white,
            fontSize: textSize,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
