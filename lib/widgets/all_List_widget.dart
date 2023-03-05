import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../view_models/add_flyer_cubit/cubit.dart';
import '../view_models/add_flyer_cubit/states.dart';

class AllCategoriesWidget extends StatelessWidget {
  const AllCategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<AddFlyerCubit, AddFlyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AddFlyerCubit cubit = AddFlyerCubit.get(context);
          return Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  fontSize: width(18),
                  text: "All Categories",
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: height(25),
                ),
                ConditionalBuilder(
                    condition: state is! GetCategoryLoadingState,
                    fallback: (context) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                    builder: (context) {
                      return Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              cubit
                                  .chooseStoreCategory(cubit.categories[index]);
                            },
                            child: Container(
                              padding: padding,
                              decoration: BoxDecoration(
                                color: color.backgroundColor,
                                border: Border.all(
                                  color: cubit.storeModel.category ==
                                          cubit.categories[index].key!
                                      ? color.primaryColor
                                      : color.hintColor.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomText(
                                fontSize: width(16),
                                text: cubit.categories[index].key!,
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: height(15),
                          ),
                          itemCount: cubit.categories.length,
                        ),
                      );
                    }),
                const Spacer(),
                CustomButton(
                  fontSize: width(16),
                  function: () {
                    Navigator.pop(context);
                  },
                  text: "Confirm",
                ),
              ],
            ),
          );
        });
  }
}

class AllStoresWidget extends StatelessWidget {
  const AllStoresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<AddFlyerCubit, AddFlyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AddFlyerCubit cubit = AddFlyerCubit.get(context);
          return Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: width(18),
                  text: "All stores",
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: height(25),
                ),
                ConditionalBuilder(
                    condition: state is! GetStoresLoadingState,
                    fallback: (context) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                    builder: (context) {
                      return Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              cubit.chooseStore(cubit.stores[index]);
                            },
                            child: Container(
                              padding: padding,
                              decoration: BoxDecoration(
                                color: color.backgroundColor,
                                border: Border.all(
                                  color: cubit.storeModel.name ==
                                          cubit.stores[index].name
                                      ? color.primaryColor
                                      : color.hintColor.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomText(
                                fontSize: width(16),
                                text: cubit.stores[index].name!,
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: height(15),
                          ),
                          itemCount: cubit.stores.length,
                        ),
                      );
                    }),
                CustomButton(
                  fontSize: width(16),
                  function: () {
                    Navigator.pop(context);
                  },
                  text: "Confirm",
                ),
              ],
            ),
          );
        });
  }
}
