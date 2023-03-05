import 'package:flutter/services.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/services/language_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/client_cubit/cubit.dart';
import 'package:flyerdeal/view_models/client_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/view_models/profile_cubit/cubit.dart';
import 'package:flyerdeal/views/AuthViews/LoginViews/login_view.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';

class ClientLayoutView extends StatelessWidget {
  const ClientLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    SizeConfig().init(context);
    return BlocConsumer<ClientCubit, ClientStates>(
      listener: (context, state) {
        if (state is OnChangeBottomNavIndex) {
          if (state.index == 1) {
            /*SearchCubit.get(context).getMapRentals();
            state.completeNavigation(true);*/
          } else if (state.index == 2) {
            /*rentxcontext
                .requireAuth(
                    () => ClientBookingsCubit.get(context).getBookings())
                .then((value) => state.completeNavigation(value));*/
          } else if (state.index == 3) {
            ProfileCubit.get(context).getUserData().then((value) {
              if (userModel == null) {
                navigateTo(
                  view: LoginView(),
                  context: context,
                );
              }
            });
          }
        }
      },
      builder: (context, state) {
        ClientCubit cubit = ClientCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: cubit.views[cubit.index],
          ),
          bottomNavigationBar: Container(
            margin: padding,
            decoration: BoxDecoration(
              boxShadow: [
                boxShadowNav,
                boxShadowNav,
              ],
              borderRadius: BorderRadius.circular(18),
              color: color.scaffoldBackgroundColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BottomNavigationBar(
                backgroundColor: color.scaffoldBackgroundColor,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(
                  color: color.primaryColor,
                  fontSize: width(12),
                ),
                unselectedLabelStyle: TextStyle(
                  color: color.hintColor,
                  fontSize: width(12),
                ),
                selectedItemColor: color.primaryColorDark,
                unselectedItemColor: color.primaryColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/compass.svg',
                      width: width(26),
                      height: height(26),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/compass.svg",
                      width: width(26),
                      height: height(26),
                      color: color.primaryColor,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/stores.svg',
                      width: width(26),
                      height: height(26),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/stores.svg",
                      width: width(26),
                      height: height(26),
                      color: color.primaryColor,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      width: width(26),
                      height: height(26),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/heart.svg",
                      width: width(26),
                      height: height(26),
                      color: color.primaryColor,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/user.svg',
                      width: width(26),
                      height: height(26),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/user.svg",
                      width: width(26),
                      height: height(26),
                      color: color.primaryColor,
                    ),
                    label: "",
                  ),
                ],
                currentIndex: cubit.index,
                onTap: (value) {
                  cubit.chooseBottomNavIndex(value);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
