import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/user_model.dart';
import 'package:flyerdeal/services/language_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/auth_cubit/cubit.dart';
import 'package:flyerdeal/views/AuthViews/LoginViews/login_view.dart';
import 'package:flyerdeal/widgets/circle_image.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_text.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../view_models/auth_cubit/states.dart';

class PersonalDataView extends StatelessWidget {
  PersonalDataView({super.key});

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProfilePictureWidget(
                    profileImage: cubit.profileImage,
                    onPickImage: cubit.chooseImage,
                    profileImageUrl: "",
                  ),
                ),
                SizedBox(
                  height: height(16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                        fontSize: width(18),
                        fontWeight: FontWeight.w600,
                        text: cubit.signUpRequest.name ?? "Create Profile"),
                    CustomText(
                        fontSize: width(18),
                        fontWeight: FontWeight.w600,
                        text: cubit.signUpRequest.surname ?? ""),
                  ],
                ),
                SizedBox(
                  height: height(2),
                ),
                Center(
                    child: CustomText(
                  fontSize: width(16),
                  text: UserRole.client.name,
                )),
                SizedBox(
                  height: height(21),
                ),
                PropertiesWidget(
                    title: "Name",
                    onChange: (value) {
                      cubit.onChangeName(value);
                    }),
                PropertiesWidget(
                    title: "Surname",
                    onChange: (value) {
                      cubit.onChangeSurName(value);
                    }),
                CustomText(
                  fontSize: width(16),
                  text: "Phone Number",
                  color: color.primaryColorDark,
                ),
                SizedBox(
                  height: height(15),
                ),
                IntlPhoneField(
                  decoration: InputDecoration(
                    alignLabelWithHint: false,
                    filled: true,
                    fillColor: color.backgroundColor,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelStyle: TextStyle(
                      color: color.primaryColor,
                      fontSize: width(20),
                    ),
                    counterStyle: TextStyle(
                      color: color.hintColor,
                      fontSize: width(14),
                      height: 1.2,
                    ),
                    labelStyle: TextStyle(
                      color: color.hintColor,
                      fontSize: width(14),
                      height: 1.2,
                    ),
                    labelText: '|  Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: color.hintColor.withOpacity(0.4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: color.primaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: height(20),
                      horizontal: width(20),
                    ),
                  ),
                  initialCountryCode: 'EG',
                  flagsButtonPadding: EdgeInsets.only(
                    top: height(20),
                    bottom: height(20),
                    left: width(20),
                  ),
                  disableLengthCheck: true,
                  showCountryFlag: true,
                  showDropdownIcon: false,
                  onChanged: (phone) {
                    cubit.onChangePhoneNumber(
                        "${phone.countryCode}${phone.number}");
                    print(cubit.signUpRequest.phoneNumber);
                  },
                ),
                SizedBox(
                  height: height(25),
                ),
                BirthdayPicker(
                  birthdate: cubit.signUpRequest.birthdate,
                  onChange: cubit.onChangeBirthDate,
                ),
                SizedBox(
                  height: height(40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      showLoader: state is RegisterLoadingState,
                      background: color.primaryColor,
                      text: 'Next',
                      radius: 6,
                      fontSize: width(16),
                      btnWidth: width(132),
                      function: () {
                        if (_formkey.currentState!.validate() &&
                            cubit.signUpRequest.birthdate != null) {
                          cubit.onNextStep();
                        }
                      },
                      isUpperCase: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BirthdayPicker extends StatelessWidget {
  const BirthdayPicker({
    Key? key,
    this.birthdate,
    required this.onChange,
  }) : super(key: key);

  final DateTime? birthdate;
  final dynamic Function(DateTime) onChange;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: birthdate ?? DateTime(2000, 1),
          firstDate: DateTime(1900, 1),
          lastDate: DateTime(DateTime.now().year - 18),
        ).then((value) {
          onChange(value!);
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            fontSize: width(16),
            text: "Birth Date",
          ),
          SizedBox(
            height: height(5),
          ),
          Container(
            width: double.infinity,
            height: height(60),
            padding: EdgeInsets.symmetric(
                horizontal: width(15), vertical: height(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: color.hintColor.withOpacity(0.4),
              ),
              color: color.backgroundColor,
            ),
            child: CustomText(
                fontSize: width(14),
                color: birthdate != null
                    ? color.primaryColorDark
                    : color.hintColor,
                text: birthdate != null
                    ? DateUtil.strDate(birthdate)
                    : translation(context).hint),
          ),
        ],
      ),
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    Key? key,
    this.profileImage,
    required this.onPickImage,
    required this.profileImageUrl,
  }) : super(key: key);

  final File? profileImage;

  final String? profileImageUrl;

  final Function(File) onPickImage;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return CustomImagePicker(
        widgetBuilder: () => SizedBox(
              height: height(100),
              width: width(101),
              child: Stack(
                children: [
                  Container(
                    width: width(90),
                    height: height(90),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: color.hintColor),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: profileImage != null
                            ? Image(
                                image: FileImage(profileImage!),
                                fit: BoxFit.cover,
                              )
                            : CheckImageAvailable(
                                profileImageUrl: profileImageUrl,
                              )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: width(34),
                      height: height(34),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.primaryColor,
                      ),
                      child: SvgPicture.asset(
                        "assets/images/pick.svg",
                        width: width(18),
                        height: height(18),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        onFilePick: onPickImage);
  }
}

class CheckImageAvailable extends StatelessWidget {
  const CheckImageAvailable({Key? key, required this.profileImageUrl})
      : super(key: key);

  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return profileImageUrl == null || profileImageUrl!.isEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(15),
              vertical: height(15),
            ),
            child: SvgPicture.asset(
              "assets/images/people.svg",
            ))
        : CachedNetworkImage(
            imageUrl: profileImageUrl!,
            fit: BoxFit.cover,
          );
  }
}
