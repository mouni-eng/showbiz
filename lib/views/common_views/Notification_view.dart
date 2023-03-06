import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/notification_cubit/cubit.dart';
import 'package:flyerdeal/view_models/notification_cubit/states.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: padding,
        child: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {},
          builder: (context, state) {
            NotificationCubit cubit = NotificationCubit.get(context);
            if (state is NotificationInitial) {
              return Center(
                child: CustomText(
                  fontSize: width(24),
                  text: 'No notifications',
                ),
              );
            } else if (state is NotificationSuccessState) {
              return Column(
                children: [
                  const CustomAppBar(
                    title: "Notification Center",
                  ),
                  SizedBox(
                    height: height(45),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: cubit.notifications.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: height(10),
                      ),
                      itemBuilder: (context, index) {
                        final message = cubit.notifications[index];
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
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
                                  "assets/images/remind.svg",
                                  color: color.primaryColorDark,
                                ),
                              ),
                              title: CustomText(
                                fontSize: width(16),
                                text: message.title ?? '',
                              ),
                              subtitle: CustomText(
                                fontSize: width(14),
                                maxlines: 2,
                                text: message.subTitle ?? '',
                              ),
                            ),
                            SizedBox(
                              height: height(10),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: color.primaryColorDark,
          ),
        ),
        SizedBox(
          width: width(15),
        ),
        CustomText(
          fontSize: width(24),
          text: title,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
