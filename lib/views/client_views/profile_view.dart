import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/services/local/cache_helper.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/views/AuthViews/LoginViews/login_view.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/views/common_views/Notification_view.dart';
import 'package:flyerdeal/views/common_views/help_support_view.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

import '../../view_models/profile_cubit/cubit.dart';
import '../../view_models/profile_cubit/states.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Padding(
      padding: padding,
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return SafeArea(
              child: Scaffold(
            body: ConditionalBuilder(
              condition: userModel != null,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      fontSize: width(24),
                      text: "profile",
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: height(32),
                    ),
                    Container(
                      padding: padding,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [boxShadow],
                        color: color.backgroundColor,
                      ),
                      child: Row(
                        children: [
                          const RoundedNetworkImage(),
                          SizedBox(
                            width: width(15),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  fontSize: width(18),
                                  text: userModel!.getFullName(),
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  color: color.hintColor,
                                  fontSize: width(14),
                                  text: userModel!.email!,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(
                                  height: height(5),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width(8),
                                    vertical: height(5),
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.hintColor.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: CustomText(
                                    color: color.primaryColorDark,
                                    fontSize: width(12),
                                    text: userModel?.role?.name ?? "Client",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height(35),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width(5),
                        vertical: height(8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: color.backgroundColor,
                        boxShadow: [boxShadow],
                      ),
                      child: Column(
                        children: [
                          CustomProfileListTile(
                            title: "Notification",
                            img: "assets/images/remind.svg",
                            onPressed: () {
                              navigateTo(
                                view: const NotificationView(),
                                context: context,
                              );
                            },
                          ),
                          const Divider(),
                          const CustomProfileListTile(
                            title: "Dark Mode",
                            img: "assets/images/moon.svg",
                            isDarkMode: true,

                            
                          ),
                          const Divider(),
                          CustomProfileListTile(
                            title: "Help And Support",
                            img: "assets/images/help.svg",
                            onPressed: () {
                              navigateTo(
                                view: const HelpAndSupportView(),
                                context: context,
                              );
                            },
                          ),
                          const Divider(),
                          CustomProfileListTile(
                            title: "LogOut",
                            img: "assets/images/logout.svg",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const LogOutWidget(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (BuildContext context) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ));
        },
      ),
    );
  }
}

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Dialog(
      child: Container(
          width: double.infinity,
          height: height(150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: color.backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: width(25),
                top: height(25),
                right: width(25),
                bottom: height(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Log Out",
                  fontSize: width(14),
                ),
                CustomText(
                    text: "Are you sure you want to log out?",
                    fontSize: width(12),
                    color: color.hintColor),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          userModel == null;
                          CacheHelper.removeData(
                            key: 'uid',
                          ).then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginView(),
                                ),
                                (route) => false);
                          });
                        },
                        child: CustomText(
                            text: "Yes",
                            fontSize: width(14),
                            color: color.primaryColor)),
                    SizedBox(
                      width: width(25),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          text: "No",
                          color: color.primaryColor,
                          fontSize: width(14),
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class CustomProfileListTile extends StatelessWidget {
  const CustomProfileListTile({
    Key? key,
    this.onPressed,
    required this.title,
    required this.img,
    this.isCustom = false,
    this.isNotify = false,
    this.isDarkMode = false,
    this.subTitle = "",
  }) : super(key: key);

  final void Function()? onPressed;
  final String title, img, subTitle;
  final bool isCustom, isNotify, isDarkMode;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return ListTile(
            onTap: onPressed,
            leading: Container(
              width: width(46),
              height: height(46),
              padding: EdgeInsets.symmetric(
                horizontal: width(10),
                vertical: height(10),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color.hintColor.withOpacity(0.4),
              ),
              child: SvgPicture.asset(
                img,
                color: color.primaryColorDark,
              ),
            ),
            title: CustomText(
              fontSize: width(16),
              text: title,
            ),
            trailing: isCustom
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(fontSize: width(16), text: subTitle),
                    ],
                  )
                : isDarkMode
                    ? Switch.adaptive(
                        value: cubit.isDarkMode,
                        activeColor: color.primaryColor,
                        onChanged: (value) {
                          cubit.onChangeDarkMode();
                        })
                    : isNotify
                        ? Switch.adaptive(
                            value: cubit.isNotify,
                            activeColor: color.primaryColor,
                            onChanged: (value) {
                              cubit.onChangeNotify();
                            })
                        : Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: color.primaryColorDark,
                          ),
          );
        });
  }
}
