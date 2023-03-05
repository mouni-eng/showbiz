import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/admin_home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/admin_home_cubit/states.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AdminHomeCubit, AdminHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminHomeCubit cubit = AdminHomeCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: padding,
                child: ConditionalBuilder(
                  condition: state is! GetAllDataLoadingState,
                  fallback: (context) => const Center(child: CircularProgressIndicator.adaptive(),),
                  builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const AuthenticatedHeader(),
                        SizedBox(
                          height: height(35),
                        ),
                        CustomText(
                          fontSize: width(24),
                          text: "Dashboard",
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: height(25),
                        ),
                        CustomInfoCard(
                          icon: "assets/images/peoples.svg",
                          title: "Total Users",
                          length: cubit.users.length,
                        ),
                        SizedBox(
                          height: height(35),
                        ),
                        CustomInfoCard(
                          icon: "assets/icons/stores.svg",
                          title: "Total Flyers",
                          length: cubit.flyers.length,
                        ),
                        SizedBox(
                          height: height(35),
                        ),
                        CustomInfoCard(
                          icon: "assets/icons/stores.svg",
                          title: "Total Stores",
                          length: cubit.stores.length,
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          );
        });
  }
}

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.length,
  }) : super(key: key);

  final String title, icon;
  final int length;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.backgroundColor,
        boxShadow: [
          boxShadow,
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              width: width(70),
              height: height(70),
              color: color.primaryColor.withOpacity(0.8),
            ),
            VerticalDivider(
              color: color.primaryColor,
            ),
            Column(
              children: [
                CustomText(
                  fontSize: width(24),
                  text: title,
                  color: color.hintColor.withOpacity(0.6),
                ),
                SizedBox(
                  height: height(5),
                ),
                CustomText(
                  fontSize: width(24),
                  text: length.round().toString(),
                  fontWeight: FontWeight.w600,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
