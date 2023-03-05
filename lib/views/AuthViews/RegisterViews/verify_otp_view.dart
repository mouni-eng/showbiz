import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/widgets/verify_otp_widget.dart';

import '../../../view_models/auth_cubit/cubit.dart';
import '../../../view_models/auth_cubit/states.dart';

class VerifyOtpView extends StatelessWidget {
  VerifyOtpView({super.key});

  final _formkey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return VerifyOtpWidget(
          loading: state is OtpConfirmedLoadingState,
          validator: (value) {
            if (value == null && value!.length < 6) {
              return 'required';
            }
          },
          onChanged: cubit.onChangePin,
          phoneNumber: cubit.signUpRequest.phoneNumber!,
          focusNode: focusNode,
          formKey: _formkey,
          onSubmit: () {
            if (_formkey.currentState!.validate()) {
              cubit.confirmOtp();
            }
          },
          onResend: () {
            cubit.verifyPhoneNumber();
          },
        );
      },
      listener: (context, state) {
        if (state is OtpConfirmedErrorState) {
          AlertService.showSnackbarAlert(
            state.error!,
            SnackbarType.error,
            context,
          );
        } else if (state is CodeSentState) {
          AlertService.showSnackbarAlert(
            "Code Sent!",
            SnackbarType.success,
            context,
          );
        } else if (state is OtpConfirmedSuccessState) {
          /*rentxcontext.route((context) => AddressSelection(),);*/
          AlertService.showSnackbarAlert(
            "Your Profile is Now Live!",
            SnackbarType.success,
            context,
          );
        }
      },
    );
  }
}
