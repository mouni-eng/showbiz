import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/searching_cubit/cubit.dart';
import 'package:flyerdeal/view_models/searching_cubit/states.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/views/common_views/flyer_listing_view.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_formField.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
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
                        text: "Search & Filter",
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => Container(
                              height: SizeConfig.screenHeight! / 2,
                              width: double.infinity,
                              padding: padding,
                              decoration: BoxDecoration(
                                color: color.backgroundColor.withOpacity(0.95),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CustomText(
                                      fontSize: width(20),
                                      text: "Sort & Filter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height(15),
                                  ),
                                  CustomText(
                                    fontSize: width(20),
                                    text: "Categories",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: height(15),
                                  ),
                                  SizedBox(
                                    height: height(80),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          CategoryCard(
                                        title: "Electronics",
                                        selected: false,
                                        onTap: () {
                                          //cubit.changeCategory(cubit.categories[index]);
                                        },
                                      ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: width(15),
                                      ),
                                      itemCount: 8,
                                    ),
                                  ),
                                  Spacer(),
                                  CustomButton(
                                    fontSize: width(16),
                                    function: () {},
                                    text: "Submit Filter",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/icons/filter.svg",
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
                  CustomFormField(
                    context: context,
                    hintText: "Search for flyers..",
                    onChange: (value) {},
                    suffix: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/images/close.svg",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(30),
                  ),
                  ConditionalBuilder(
                      condition: cubit.searchedList.isNotEmpty,
                      fallback: (context) => Expanded(
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/searching-img.svg",
                                width: width(300),
                                height: height(300),
                              ),
                            ),
                          ),
                      builder: (context) {
                        return Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                FlyerHorizontalCard(
                              flyerModel: cubit.searchedList[index],
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: height(25),
                            ),
                            itemCount: cubit.searchedList.length,
                          ),
                        );
                      }),
                ],
              ),
            )),
          );
        });
  }
}
