import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import your design/text widgets
import 'package:pcom_app/common/widgets/my_text.dart';
import 'package:pcom_app/app/core/core.dart';

class PaymentWebView extends StatefulWidget {
  final String initialUrl;

  const PaymentWebView({super.key, required this.initialUrl});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (int progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          // OPTIONAL: Intercept URL to detect Payment Success/Failure
          onNavigationRequest: (NavigationRequest request) {
            // Example: If your website redirects to /order-received or /success
            if (request.url.contains('order-received') || request.url.contains('success')) {
              Get.back(result: 'success'); // Close WebView and return success
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Secure Payment", fontSize: 18),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(), // User cancelled payment
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          // Loading Bar
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              color: R.theme.primary,
            ),
        ],
      ),
    );
  }
}