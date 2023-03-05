import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    Key? key,
    required this.title,
    required this.onPressed,
    this.value,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final String? value;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontSize: width(16),
          text: title,
        ),
        SizedBox(
          height: height(15),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              border: Border.all(
                color: color.hintColor.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/calendar.svg",
                ),
                SizedBox(
                  width: width(10),
                ),
                CustomText(
                  fontSize: width(14),
                  text: value!.isEmpty ? "Choose date" : value!,
                  color: color.hintColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}