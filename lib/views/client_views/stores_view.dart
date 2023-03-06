import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/home_cubit/states.dart';
import 'package:flyerdeal/view_models/wishlist_cubit/cubit.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/views/common_views/search_view.dart';
import 'package:flyerdeal/views/common_views/web_view.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../../view_models/wishlist_cubit/states.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
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
                        text: "Stores (${cubit.stores.length})",
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
                    child: ConditionalBuilder(
                        condition: state is! GetAllCategoriesLoading,
                        fallback: (context) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                        builder: (context) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CategoryCard(
                              title: cubit.categories[index].key!,
                              selected:
                                  cubit.category == cubit.categories[index].key,
                              onTap: () {
                                cubit.changeCategory(
                                    cubit.categories[index].key!);
                              },
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              width: width(15),
                            ),
                            itemCount: cubit.categories.length,
                          );
                        }),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => StoreHorizontalCard(
                        storeModel: cubit.category == null
                            ? cubit.stores[index]
                            : cubit.filterdStores[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: height(25),
                      ),
                      itemCount: cubit.category == null
                          ? cubit.stores.length
                          : cubit.filterdStores.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class StoreHorizontalCard extends StatelessWidget {
  const StoreHorizontalCard({
    Key? key,
    required this.storeModel,
  }) : super(key: key);

  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Container(
      width: double.infinity,
      height: height(120),
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
              storeModel.image!,
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
                        text: storeModel.name!,
                        maxlines: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: width(5),
                    ),
                    BlocConsumer<WishListCubit, WishListStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          WishListCubit cubit = WishListCubit.get(context);
                          return ConditionalBuilder(
                              condition: state is! GetWishListLoadingState,
                              fallback: (context) => Container(),
                              builder: (context) {
                                return FavouriteButton(
                                  onPressed: () {
                                    cubit.toogleStoreFavourite(
                                      isFavourite: CheckUtil.isStoreFavourite(
                                        storeModel: storeModel,
                                        favourites: cubit.stores,
                                      ),
                                      store: storeModel,
                                    );
                                  },
                                  isFavourite: CheckUtil.isStoreFavourite(
                                    storeModel: storeModel,
                                    favourites: cubit.stores,
                                  ),
                                );
                              });
                        }),
                  ],
                ),
                SizedBox(
                  height: height(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomText(
                        fontSize: width(15),
                        text: storeModel.category!,
                        maxlines: 1,
                        color: color.hintColor,
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
                              view: CustomWebView(website: storeModel.website!),
                              context: context);
                        },
                        text: "Website",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
