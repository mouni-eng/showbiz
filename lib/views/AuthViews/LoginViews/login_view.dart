import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/services/language_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/auth_cubit/cubit.dart';
import 'package:flyerdeal/view_models/auth_cubit/states.dart';
import 'package:flyerdeal/views/AuthViews/LoginViews/reset_password_view.dart';
import 'package:flyerdeal/views/AuthViews/RegisterViews/registration_layout_view.dart';
import 'package:flyerdeal/views/client_views/layout_screen.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_formField.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    SizeConfig().init(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is LogInErrorState) {
        AlertService.showSnackbarAlert(
            "Email or Password is incorrect!", SnackbarType.error, context);
      } else if (state is LogInSuccessState) {
        navigateTo(view: const ClientLayoutView(), context: context);
      }
    }, builder: (context, state) {
      AuthCubit cubit = AuthCubit.get(context);
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: padding,
          child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(40),
                    ),
                    CustomText(
                      fontSize: width(28),
                      text: translation(context).login,
                      color: color.primaryColorDark,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: height(10),
                    ),
                    CustomText(
                      fontSize: width(14),
                      text: translation(context).logindetails,
                      color: color.hintColor,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: height(45),
                    ),
                    PropertiesWidget(
                      title: translation(context).email,
                      textEditingController: cubit.userNameController,
                      onChange: (value) {
                        cubit.onChangeEmailAddress(value);
                      },
                    ),
                    PropertiesWidget(
                      title: translation(context).password,
                      onChange: (value) {
                        cubit.onChangePassword(value);
                      },
                      isPassword: true,
                      textEditingController: cubit.userPasswordController,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          navigateTo(
                            view: ForgotPasswordView(),
                            context: context,
                          );
                        },
                        child: CustomText(
                          fontSize: width(14),
                          text: translation(context).forgotPassword,
                          color: color.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height(40),
                    ),
                    CustomButton(
                      btnWidth: double.infinity,
                      background: color.primaryColor,
                      showLoader: state is LogInLoadingState,
                      fontSize: width(16),
                      isUpperCase: false,
                      function: () {
                        if (_formkey.currentState!.validate()) {
                          cubit.logIn();
                        }
                      },
                      text: translation(context).login,
                    ),
                    SizedBox(
                      height: height(80),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          fontSize: width(14),
                          text: translation(context).dontHaveAnAccount,
                          color: color.primaryColorDark,
                        ),
                        SizedBox(
                          width: width(5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserRegistrationLayout()));
                          },
                          child: CustomText(
                            fontSize: width(14),
                            text: translation(context).registerNow,
                            color: color.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(40),
                    ),
                  ],
                ),
              )),
        )),
      );
    });
  }
}

class SocialBoxWidget extends StatelessWidget {
  const SocialBoxWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color.hintColor.withOpacity(0.3),
          )),
      child: SvgPicture.asset(
        image,
      ),
    );
  }
}

class PropertiesWidget extends StatelessWidget {
  const PropertiesWidget(
      {Key? key,
      required this.title,
      this.textEditingController,
      this.onChange,
      this.validate,
      this.isPassword = false,
      this.isAboutMe = false,
      this.isPhoneNumber = false,
      this.customBuilder,
      this.length})
      : super(key: key);

  final String? title;
  final TextEditingController? textEditingController;
  final void Function(String)? onChange;
  final String? Function(String?)? validate;
  final bool isPassword, isAboutMe, isPhoneNumber;
  final Widget Function(BuildContext, int)? customBuilder;
  final int? length;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontSize: width(16),
          text: title!,
          color: color.primaryColorDark,
        ),
        SizedBox(
          height: height(15),
        ),
        if (customBuilder == null)
          CustomFormField(
            context: context,
            controller: textEditingController,
            onChange: onChange,
            maxLines: isAboutMe ? 20 : 1,
            hintText: translation(context).hint,
            validate: (value) {
              if (value!.isEmpty) {
                return translation(context).requiredField;
              }
              return null;
            },
            type: isPhoneNumber == true
                ? TextInputType.number
                : TextInputType.emailAddress,
            isPassword: isPassword,
            isAboutMe: isAboutMe,
          ),
        if (customBuilder != null)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: customBuilder!,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        SizedBox(
          height: height(25),
        ),
      ],
    );
  }
}
