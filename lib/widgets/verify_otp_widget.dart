import 'package:flutter/material.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_text.dart';
import 'package:pinput/pinput.dart';
import 'package:flyerdeal/size_config.dart';

class VerifyOtpWidget extends StatelessWidget {
  const VerifyOtpWidget(
      {Key? key,
      this.loading,
      required this.formKey,
      required this.onSubmit,
      this.validator,
      this.email,
      this.onChanged,
      this.focusNode,
      this.phoneNumber,
      required this.onResend})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool? loading;
  final Function() onSubmit;
  final Function() onResend;
  final FormFieldValidator<String>? validator;
  final String? email, phoneNumber;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var pinTheme = PinTheme(
      width: width(49),
      height: height(48),
      textStyle: TextStyle(
        fontSize: width(16),
        color: color.primaryColorDark,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.transparent,
        ),
        boxShadow: [boxShadow],
        color: color.cardColor,
      ),
    );
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: const AssetImage("assets/images/message.png"),
                width: width(130),
                height: height(130),
              ),
            ),
            SizedBox(
              height: height(30),
            ),
            CustomText(
              align: TextAlign.center,
              color: color.hintColor,
              textOverflow: TextOverflow.clip,
              fontSize: width(16),
              text:
                  'Please enter the 6 digit code sent to ${email ?? phoneNumber}',
            ),
            SizedBox(
              height: height(55),
            ),
            CustomText(fontSize: width(14), text: "Otp Verification"),
            SizedBox(
              height: height(25),
            ),
            Pinput(
              length: 6,
              pinAnimationType: PinAnimationType.scale,
              focusNode: focusNode,
              validator: validator,
              onChanged: onChanged,
              defaultPinTheme: pinTheme,
              focusedPinTheme: PinTheme(
                width: width(49),
                height: height(48),
                textStyle: TextStyle(
                  fontSize: width(16),
                  color: color.primaryColorDark,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.primaryColor,
                  ),
                  color: color.cardColor,
                ),
              ),
              submittedPinTheme: pinTheme,
              followingPinTheme: pinTheme,
            ),
            SizedBox(
              height: height(14),
            ),
            Center(
              child: GestureDetector(
                  onTap: onResend,
                  child: CustomText(
                    color: color.primaryColor,
                    fontSize: width(14),
                    text: "Resend Code",
                  )),
            ),
            SizedBox(
              height: height(135),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                CustomButton(
                  showLoader: loading,
                  text: "Confirm",
                  radius: 6,
                  fontSize: width(16),
                  btnWidth: width(132),
                  btnHeight: height(50),
                  function: onSubmit,
                  isUpperCase: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
