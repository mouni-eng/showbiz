import 'package:flutter/material.dart';
import 'package:flyerdeal/size_config.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool isPassword;
  final String? Function(String?)? validate;
  final String? label;
  final int? maxLines;
  final String? hintText;
  final int? maxLength;
  final Widget? prefix;
  final bool isAboutMe;
  final BuildContext context;
  final Widget? suffix;
  final bool isClickable;
  final bool isMapSearch;

  const CustomFormField({
    Key? key,
    required this.context,
    this.hintText,
    this.controller,
    this.isClickable = true,
    this.isPassword = false,
    this.label,
    this.maxLength,
    this.isAboutMe = false,
    this.maxLines = 1,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.type,
    this.validate,
    this.isMapSearch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        hintText: hintText,
        fillColor: color.backgroundColor,
        filled: true,
        errorStyle: const TextStyle(
          height: 0,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        counterText: "",
        focusColor: Colors.transparent,
        prefixIcon: prefix,
        suffixIcon: suffix,
        contentPadding: EdgeInsets.only(
            right: isMapSearch == true ? 0 : width(15),
            top: height(20),
            bottom: height(20),
            left: isMapSearch == true ? 0 : width(15)),
        hintStyle: TextStyle(
          fontSize: width(14),
          color: color.hintColor,
        ),
        labelStyle: TextStyle(
          color: color.hintColor,
          fontSize: width(14),
        ),
        alignLabelWithHint: false,
        floatingLabelStyle: TextStyle(
          color: color.primaryColor,
          fontSize: width(18),
        ),
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
      ),
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}
