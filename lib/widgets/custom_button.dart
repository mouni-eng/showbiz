import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/size_config.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double? btnWidth;
  final double? btnHeight;
  final Color? background;
  final bool? isUpperCase;
  final double? radius;
  final double? fontSize;
  final Function()? function;
  final String? text;
  final String? svgLeadingIcon;
  final bool? showLoader;
  final bool? enabled;
  final FontWeight? fontWeight;

  const CustomButton({
    Key? key,
    this.btnWidth = double.infinity,
    this.background,
    this.radius = 8.0,
    required this.fontSize,
    this.isUpperCase = false,
    required this.function,
    required this.text,
    this.svgLeadingIcon,
    this.showLoader = false,
    this.btnHeight = 48,
    this.enabled = true,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bg = background ?? Theme.of(context).primaryColor;
    return Container(
      width: btnWidth,
      height: btnHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius!,
        ),
        color: showLoader! || !enabled! ? bg.withOpacity(0.3) : bg,
      ),
      child: MaterialButton(
          onPressed: showLoader! || !enabled! ? null : function,
          child: _rowWidget(context)),
    );
  }

  Widget _rowWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (svgLeadingIcon != null)
          SvgPicture.asset(
            svgLeadingIcon!,
          ),
        if (svgLeadingIcon != null)
          SizedBox(
            width: width(14),
          ),
        if (showLoader!)
          SizedBox(
              width: height(btnHeight! * 0.7),
              height: height(btnHeight! * 0.7),
              child: const CircularProgressIndicator.adaptive()),
        if (showLoader!)
          SizedBox(
            width: width(14),
          ),
        _textWidget(context),
      ],
    );
  }

  Widget _textWidget(context) {
    return Expanded(
        child: Center(
      child: CustomText(
        text: isUpperCase! ? text!.toUpperCase() : text!,
        color: Theme.of(context).backgroundColor,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize!,
      ),
    ));
  }
}
