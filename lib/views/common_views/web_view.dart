import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/views/common_views/Notification_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({super.key, required this.website});
  final String website;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: padding / 2,
              child: const CustomAppBar(
                title: "Website View",
              ),
            ),
            SizedBox(
              height: height(25),
            ),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: website,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
