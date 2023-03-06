import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/views/common_views/Notification_view.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              const CustomAppBar(
                title: "Help & Support",
              ),
              Expanded(
                child: Center(
                  child: CustomText(
                    fontSize: width(24),
                    text: "Comming soon",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
