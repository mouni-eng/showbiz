import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/views/common_views/web_view.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class FlyerDetailsView extends StatelessWidget {
  const FlyerDetailsView({super.key, required this.flyerModel});

  final FlyerModel flyerModel;

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
                      text: flyerModel.name!,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: height(5),
                    ),
                    CustomText(
                      fontSize: width(14),
                      text: DateUtil.displayDiffrence(
                          flyerModel.from!, flyerModel.to!),
                      color: color.hintColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
          Expanded(
            child: const PDF().cachedFromUrl(
              flyerModel.flyerPdf!,
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
            child: Center(
              child: GestureDetector(
                onTap: () {
                  navigateTo(
                    view: CustomWebView(website: flyerModel.store!.website!),
                    context: context,
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/stores.svg",
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
