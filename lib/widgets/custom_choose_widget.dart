import 'package:flutter/material.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class CustomChooseWidget extends StatelessWidget {
  const CustomChooseWidget({
    Key? key,
    required this.title,
    required this.icon, required this.onPressed,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: height(18),
          horizontal: width(16),
        ),
        decoration: BoxDecoration(
            color: color.backgroundColor,
            border: Border.all(
              color: color.hintColor.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: width(14),
              color: color.hintColor,
            ),
            icon,
          ],
        ),
      ),
    );
  }
}