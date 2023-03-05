import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/widgets/all_List_widget.dart';
import 'package:flyerdeal/widgets/circle_image.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_choose_widget.dart';
import 'package:flyerdeal/widgets/custom_date_picker.dart';
import 'package:flyerdeal/widgets/custom_formField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/add_flyer_cubit/cubit.dart';
import 'package:flyerdeal/views/AuthViews/RegisterViews/personal_data_view.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../view_models/add_flyer_cubit/states.dart';

class AddFlyerWidget extends StatelessWidget {
  const AddFlyerWidget({super.key, required this.formkey});

  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<AddFlyerCubit, AddFlyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                          cubit.chooseFlyerImage(value);
                        },
                        profileImageUrl: cubit.flyerModel.image,
                        profileImage: cubit.flyerImage,
                      ),
                    ),
                    SizedBox(
                      height: height(15),
                    ),
                    Center(
                      child: CustomText(
                        fontSize: width(18),
                        text: "Add Flyer Image",
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
                            hintText: "Flyer Name",
                            onChange: (value) {
                              cubit.chooseFlyerName(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: width(25),
                        ),
                        Expanded(
                          child: CustomImagePicker(
                            widgetBuilder: () => Container(
                              padding: padding,
                              decoration: BoxDecoration(
                                color: cubit.flyerPdf != null
                                    ? color.scaffoldBackgroundColor
                                    : color.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: cubit.flyerPdf != null
                                      ? color.hintColor.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                              child: cubit.flyerPdf != null
                                  ? SvgPicture.asset(
                                      "assets/images/success.svg")
                                  : Center(
                                      child: CustomText(
                                        fontSize: width(16),
                                        text: "Pick Pdf",
                                        color: color.scaffoldBackgroundColor,
                                      ),
                                    ),
                            ),
                            isPdf: true,
                            onFilePick: (value) {
                              cubit.chooseFlyerPdf(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(35),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDatePicker(
                          title: "Available From",
                          onPressed: () {
                            cubit.chooseFromDate(context: context);
                          },
                          value: DateUtil.strDate(cubit.flyerModel.from),
                        ),
                        SizedBox(
                          width: width(15),
                        ),
                        CustomDatePicker(
                          title: "Available To",
                          onPressed: () {
                            cubit.chooseToDate(context: context);
                          },
                          value: DateUtil.strDate(cubit.flyerModel.to),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(60),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomChooseWidget(
                            title: "Store",
                            icon: SvgPicture.asset(
                              "assets/images/pick.svg",
                              color: color.primaryColor,
                            ),
                            onPressed: () {
                              cubit.getStores();
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext buildContext) {
                                  return AllStoresWidget();
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: width(40),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            showLoader: state is AddFlyerLoadingState,
                            btnWidth: width(150),
                            fontSize: width(16),
                            function: () {
                              if (formkey.currentState!.validate() &&
                                  cubit.flyerPdf != null &&
                                  cubit.flyerImage != null &&
                                  cubit.flyerModel.from != null &&
                                  cubit.flyerModel.to != null) {
                                cubit.addFlyer();
                              } else {
                                AlertService.showSnackbarAlert(
                                  formMessage,
                                  SnackbarType.warning,
                                  context,
                                );
                              }
                            },
                            text: "Next",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
