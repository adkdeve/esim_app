import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcom_app/common/widgets/my_text.dart';

import '../../app/core/core.dart';

class SnackBarUtils {
  static showError(String message, [int duration = 2]) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        duration: Duration(seconds: duration),
        backgroundColor: R.theme.error,
        borderRadius: 12,
        messageText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline_outlined,
                    color: R.theme.black,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MyText(
                      // softWrap: true,
                      text: message,
                      fontSize: 13,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w400,
                      color: R.theme.black,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.closeCurrentSnackbar();
              },
              child: const MyText(
                text: 'Close',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                // color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showSnackBar(String message, [int duration = 2]) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        duration: Duration(seconds: duration),

        // isDismissible: false,
        backgroundColor: R.theme.green,
        borderRadius: 12,
        messageText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: R.theme.black,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MyText(
                      // softWrap: true,
                      text: message,
                      fontSize: 13,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w400,
                      color: R.theme.black,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.closeCurrentSnackbar();
              },
              child: MyText(
                text: 'Close',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: R.theme.black,
              ),
            ),
          ],
        ),
      ),
    );

    // Get.showSnackbar(GetSnackBar(
    //   message: message,
    //   duration: const Duration(seconds: 2),
    // ));
  }

  static showScaffoldSnackBar(BuildContext buildContext, String message) {
    ScaffoldMessenger.of(
      buildContext,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
