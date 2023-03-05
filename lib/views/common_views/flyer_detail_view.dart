import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/custom_text.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class FlyerDetailsView extends StatelessWidget {
  const FlyerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded)),
                Column(
                  children: [
                    CustomText(
                      fontSize: width(20),
                      text: "Peavy Mart Flyer",
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: height(5),
                    ),
                    CustomText(
                      fontSize: width(14),
                      text: "Valid till 6 days",
                      color: color.hintColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.hintColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/heart.svg",
                    width: width(20),
                    height: height(20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: const PDF().cachedFromUrl(
              'http://africau.edu/images/default/sample.pdf',
              placeholder: (progress) => Center(
                child: Text('$progress %'),
              ),
              errorWidget: (error) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: color.backgroundColor,
              boxShadow: [
                boxShadow,
                boxShadow,
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  "assets/icons/stores.svg",
                ),
                SvgPicture.asset(
                  "assets/icons/share.svg",
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
