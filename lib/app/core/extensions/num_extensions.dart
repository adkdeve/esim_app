import 'package:flutter/material.dart';

extension NumSpacing on num {
  SizedBox get sbh => SizedBox(height: toDouble());
  SizedBox get sbw => SizedBox(width: toDouble());

  EdgeInsets get all => EdgeInsets.all(toDouble());
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get right => EdgeInsets.only(right: toDouble());

  BorderRadius get radius => BorderRadius.circular(toDouble());
}
