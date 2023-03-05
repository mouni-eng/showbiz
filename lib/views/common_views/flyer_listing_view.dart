import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/views/common_views/flyer_detail_view.dart';
import 'package:flyerdeal/views/common_views/search_view.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class FlyerListingView extends StatelessWidget {
  const FlyerListingView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                CustomText(
                  fontSize: width(20),
                  text: title,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                        onTap: () {
                          navigateTo(
                            view: const SearchView(),
                            context: context,
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          color: color.primaryColorDark,
                          width: width(30),
                          height: height(30),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: height(25),
            ),
            CustomText(
              fontSize: width(18),
              text: "Flyers (6)",
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: height(25),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => FlyerHorizontalCard(
                  flyerModel: flyerModel,
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: height(25),
                ),
                itemCount: 6,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class FlyerHorizontalCard extends StatelessWidget {
  const FlyerHorizontalCard({
    Key? key,
    required this.flyerModel,
  }) : super(key: key);

  final FlyerModel flyerModel;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Container(
      width: double.infinity,
      height: height(150),
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: [
          boxShadow,
        ],
        color: color.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              flyerModel.image!,
              fit: BoxFit.cover,
              width: width(100),
              height: double.infinity,
            ),
          ),
          SizedBox(
            width: width(15),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        fontSize: width(18),
                        text: flyerModel.name!,
                        maxlines: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: width(10),
                    ),
                    const FavouriteButton(),
                  ],
                ),
                SizedBox(
                  height: height(5),
                ),
                CustomText(
                  fontSize: width(14),
                  text: flyerModel.category!,
                  maxlines: 1,
                  color: color.hintColor,
                  fontWeight: FontWeight.w400,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomText(
                        fontSize: width(12),
                        color: color.hintColor.withOpacity(0.6),
                        text:
                            "Valid till ${DateUtil.displayRange(flyerModel.from!, flyerModel.to!)} days",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        btnHeight: height(35),
                        fontSize: width(15),
                        fontWeight: FontWeight.w400,
                        function: () {
                          navigateTo(
                              view: FlyerDetailsView(), context: context);
                        },
                        text: "Details",
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
