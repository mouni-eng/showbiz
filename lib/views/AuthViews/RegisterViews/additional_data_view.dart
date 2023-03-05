import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/views/AuthViews/LoginViews/login_view.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../../../view_models/auth_cubit/cubit.dart';
import '../../../view_models/auth_cubit/states.dart';

class AdditionalDataView extends StatelessWidget {
  AdditionalDataView({super.key});

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthStates>(builder: (context, state) {
      AuthCubit cubit = AuthCubit.get(context);
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PropertiesWidget(
                title: "Username",
                onChange: (value) {
                  cubit.onChangeUserName(value);
                },
              ),
              PropertiesWidget(
                title: "Email Address",
                onChange: (value) {
                  cubit.onChangeEmailAddress(value);
                },
              ),
              PropertiesWidget(
                title: "Password",
                isPassword: true,
                onChange: (value) {
                  cubit.onChangePassword(value);
                },
              ),
              PropertiesWidget(
                isPassword: true,
                title: "Confirm Password",
                onChange: (value) {
                  cubit.onChangeConfirmPassword(value);
                },
              ),
              SizedBox(
                height: height(115),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        cubit.onBackStep();
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: width(16),
                          color: color.primaryColorDark,
                        ),
                      )),
                  CustomButton(
                    showLoader: state is RegisterLoadingState,
                    background: color.primaryColor,
                    text: "Next",
                    radius: 6,
                    fontSize: width(16),
                    btnWidth: width(132),
                    btnHeight: height(50),
                    function: () {
                      if (_formkey.currentState!.validate()) {
                        cubit.saveUser();
                      }
                    },
                    isUpperCase: false,
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      _formkey.currentState!.validate();
      if (state is RegisterErrorState) {
        AlertService.showSnackbarAlert(
          state.error ?? 'Email address is already used',
          SnackbarType.error,
          context,
        );
      }
    });
  }
}
