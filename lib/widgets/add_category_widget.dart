import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_formField.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../view_models/add_flyer_cubit/cubit.dart';
import '../view_models/add_flyer_cubit/states.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({super.key, required this.formkey});

  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFlyerCubit, AddFlyerStates>(
        listener: (context, state) {
      if (state is AddCategorySuccessState) {
        AlertService.showSnackbarAlert(
          "Category Added",
          SnackbarType.success,
          context,
        );
      } else if(state is AddCategoryErrorState) {
        AlertService.showSnackbarAlert(
          errorMessage,
          SnackbarType.error,
          context,
        );
      }
    }, builder: (context, state) {
      AddFlyerCubit cubit = AddFlyerCubit.get(context);
      return Expanded(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Form(
            key: formkey,
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomText(
                  fontSize: width(18),
                  text: "Add Category",
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: height(25),
                ),
                CustomFormField(
                  context: context,
                  onChange: (value) {
                    cubit.chooseCategory(value);
                  },
                  hintText: "Enter Category",
                ),
                SizedBox(
                  height: height(300),
                ),
                CustomButton(
                  showLoader: state is AddCategoryLoadingState,
                  fontSize: width(16),
                  function: () {
                    if (formkey.currentState!.validate()) {
                      cubit.addCategory();
                    }
                  },
                  text: "Submit",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
