import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/home_cubit/states.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/views/common_views/flyer_listing_view.dart';
import 'package:flyerdeal/views/common_views/search_view.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class CategoryListingView extends StatelessWidget {
  const CategoryListingView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
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
                        text: "Categories",
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
                    height: height(15),
                  ),
                  SizedBox(
                    height: height(80),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoryCard(
                        title: cubit.categories[index].key!,
                        selected: cubit.category == cubit.categories[index].key,
                        onTap: () {
                          cubit.changeCategory(cubit.categories[index].key!);
                        },
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: width(15),
                      ),
                      itemCount: cubit.categories.length,
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => FlyerHorizontalCard(
                        flyerModel: cubit.filterdFlyers[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: height(25),
                      ),
                      itemCount: cubit.filterdFlyers.length,
                    ),
                  ),
                ],
              ),
            )),
          );
        });
  }
}
