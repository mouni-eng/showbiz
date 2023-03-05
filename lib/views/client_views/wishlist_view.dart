import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/Favourites_cubit/cubit.dart';
import 'package:flyerdeal/view_models/Favourites_cubit/states.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/views/client_views/stores_view.dart';
import 'package:flyerdeal/views/common_views/flyer_listing_view.dart';
import 'package:flyerdeal/views/common_views/search_view.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<FavouritesCubit, FavouritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FavouritesCubit.get(context);
          return SafeArea(
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        fontSize: width(24),
                        text: "Favourites",
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
                  Row(
                    children: [
                      TypeCard(
                        title: Type.flyers.name.toUpperCase(),
                        onTap: () {
                          cubit.changeFavouriteType(Type.flyers);
                        },
                        selected: cubit.favouriteType == Type.flyers,
                      ),
                      SizedBox(
                        width: width(20),
                      ),
                      TypeCard(
                        title: Type.stores.name.toUpperCase(),
                        onTap: () {
                          cubit.changeFavouriteType(Type.stores);
                        },
                        selected: cubit.favouriteType == Type.stores,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  cubit.favouriteType == Type.stores
                      ? Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                StoreHorizontalCard(
                              storeModel: cubit.stores[index],
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: height(25),
                            ),
                            itemCount: cubit.stores.length,
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                FlyerHorizontalCard(
                              flyerModel: cubit.flyers[index],
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: height(25),
                            ),
                            itemCount: cubit.flyers.length,
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}

class TypeCard extends StatelessWidget {
  const TypeCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth! / 2.5,
        padding: EdgeInsets.symmetric(
          horizontal: width(16),
          vertical: height(10),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [boxShadow],
          color: selected ? color.primaryColor : color.backgroundColor,
        ),
        child: Center(
          child: CustomText(
            fontSize: width(18),
            text: title,
            color: selected ? color.backgroundColor : color.hintColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
