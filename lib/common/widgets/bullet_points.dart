import 'package:flutter/material.dart';
import '../../app/core/core.dart';
import 'my_text.dart';

class Bullets extends StatelessWidget {
  const Bullets({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (t) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  text: '•  ',
                  color: R.theme.grey,
                  fontSize: 15
              ),
              Expanded(
                child: MyText(
                  text: t,
                  color: R.theme.grey,
                  fontSize: 15,
                  height: 1.4,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}