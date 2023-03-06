import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/auth_cubit/cubit.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_formField.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../../../view_models/auth_cubit/states.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is ResetPasswordErrorState) {
          AlertService.showSnackbarAlert(
              "Email is incorrect!", SnackbarType.error, context);
        } else if (state is ResetPasswordSuccessState) {
          AlertService.showSnackbarAlert(
              "Code Sent!", SnackbarType.success, context);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width(16)),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: height(20),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                            )),
                        SizedBox(
                          width: width(15),
                        ),
                        CustomText(
                          fontSize: width(18),
                          text: "Reset Password",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(40),
                    ),
                    Image.asset(
                      "assets/images/message.png",
                      width: width(165),
                      height: height(152),
                    ),
                    SizedBox(
                      height: height(70),
                    ),
                    CustomText(
                      text: "Forgot Your Password?",
                      height: 1,
                      color: color.primaryColorDark,
                      fontWeight: FontWeight.w600,
                      fontSize: width(16),
                    ),
                    SizedBox(
                      height: height(30),
                    ),
                    CustomText(
                      text:
                          "To recover your password, you need to enter your registered email address. we will send the\nrecovery code to your email",
                      color: color.primaryColorDark.withOpacity(0.75),
                      fontSize: width(16),
                      align: TextAlign.center,
                      maxlines: 3,
                    ),
                    SizedBox(
                      height: height(65),
                    ),
                    Form(
                      key: _formKey,
                      child: CustomFormField(
                        context: context,
                        controller: emailEditingController,
                        type: TextInputType.emailAddress,
                        label: "Email Address",
                      ),
                    ),
                    SizedBox(
                      height: height(50),
                    ),
                    CustomButton(
                      isUpperCase: true,
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.resetPassword(
                            email: emailEditingController.text,
                          );
                        }
                      },
                      text: "Send Link",
                      fontSize: width(14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
