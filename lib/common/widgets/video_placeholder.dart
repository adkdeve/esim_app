import 'package:flutter/material.dart';
import '../../app/core/core.dart';
import 'my_text.dart';

class VideoPlaceholder extends StatelessWidget {
  final double height;
  final String text;

  const VideoPlaceholder({
    super.key,
    this.height = 155,
    this.text = 'Video goes here',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: R.theme.secondary,
        borderRadius: 12.radius,
      ),
      child: Center(
        child: MyText(
          text: text,
          color: R.theme.grey,
          fontSize: 15,
        ),
      ),
    );
  }
}
