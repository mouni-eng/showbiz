import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/add_flyer_cubit/cubit.dart';
import 'package:flyerdeal/view_models/location_cubit/states.dart';
import 'package:flyerdeal/views/AuthViews/RegisterViews/personal_data_view.dart';
import 'package:flyerdeal/widgets/all_List_widget.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_choose_widget.dart';
import 'package:flyerdeal/widgets/custom_formField.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../view_models/add_flyer_cubit/states.dart';

class AddStoresWidget extends StatelessWidget {
  const AddStoresWidget({super.key, required this.formkey});

  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return BlocConsumer<AddFlyerCubit, AddFlyerStates>(
        listener: (context, state) {
      if (state is AddStoreSuccessState) {
        AlertService.showSnackbarAlert(
          "Store added",
          SnackbarType.success,
          context,
        );
      }
    }, builder: (context, state) {
      AddFlyerCubit cubit = AddFlyerCubit.get(context);
      return Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Center(
                  child: ProfilePictureWidget(
                    onPickImage: (value) {
                      cubit.chooseStoreImage(value);
                    },
                    profileImageUrl: cubit.storeModel.image,
                    profileImage: cubit.storeImage,
                  ),
                ),
                SizedBox(
                  height: height(15),
                ),
                Center(
                  child: CustomText(
                    fontSize: width(18),
                    text: "Add Store Logo",
                  ),
                ),
                SizedBox(
                  height: height(35),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        context: context,
                        hintText: "Store Name",
                        onChange: (value) {
                          cubit.chooseStoreName(value);
                        },
                      ),
                    ),
                    SizedBox(
                      width: width(25),
                    ),
                    Expanded(
                      child: CustomChooseWidget(
                        title: "Category",
                        icon: SvgPicture.asset(
                          "assets/images/pick.svg",
                          color: color.primaryColor,
                        ),
                        onPressed: () {
                          cubit.getCategories();
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext buildContext) {
                                return AllCategoriesWidget();
                              });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(35),
                ),
                CustomFormField(
                  context: context,
                  hintText: "Website Url: https/peavyMart.com/",
                  onChange: (value) {
                    cubit.chooseStoreWebsite(value);
                  },
                ),
                SizedBox(
                  height: height(90),
                ),
                CustomButton(
                  showLoader: state is AddStoreLoadingState,
                  fontSize: width(16),
                  function: () {
                    if (formkey.currentState!.validate() &&
                        cubit.storeModel.name != null &&
                        cubit.storeModel.website != null &&
                        cubit.categoryModel.key != null) {
                      cubit.addStore();
                    } else {
                      AlertService.showSnackbarAlert(
                        formMessage,
                        SnackbarType.warning,
                        context,
                      );
                    }
                  },
                  text: "Add Store",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
