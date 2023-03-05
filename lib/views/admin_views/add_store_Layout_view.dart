import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/services/alert_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/add_flyer_cubit/cubit.dart';
import 'package:flyerdeal/view_models/add_flyer_cubit/states.dart';
import 'package:flyerdeal/views/AuthViews/RegisterViews/personal_data_view.dart';
import 'package:flyerdeal/views/client_views/wishlist_view.dart';
import 'package:flyerdeal/widgets/add_category_widget.dart';
import 'package:flyerdeal/widgets/add_flyer_widget.dart';
import 'package:flyerdeal/widgets/add_store_widget.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class AddStoreFlyerView extends StatelessWidget {
  AddStoreFlyerView({super.key});

  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFlyerCubit, AddFlyerStates>(
        listener: (context, state) {
      if (state is AddFlyerSuccessState) {
        AlertService.showSnackbarAlert(
          "Flyer added",
          SnackbarType.success,
          context,
        );
      } else if (state is AddFlyerErrorState) {
        AlertService.showSnackbarAlert(
          errorMessage,
          SnackbarType.error,
          context,
        );
      }
    }, builder: (context, state) {
      AddFlyerCubit cubit = AddFlyerCubit.get(context);
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                fontSize: width(24),
                text: "Add Flyer & Categories",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: height(32),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TypeCard(
                      title: AdminType.flyers.name.toUpperCase(),
                      onTap: () {
                        cubit.toggleType(value: AdminType.flyers);
                      },
                      selected: cubit.type == AdminType.flyers,
                    ),
                    SizedBox(
                      width: width(20),
                    ),
                    TypeCard(
                      title: AdminType.stores.name.toUpperCase(),
                      onTap: () {
                        cubit.toggleType(value: AdminType.stores);
                      },
                      selected: cubit.type == AdminType.stores,
                    ),
                    SizedBox(
                      width: width(20),
                    ),
                    TypeCard(
                      title: AdminType.category.name.toUpperCase(),
                      onTap: () {
                        cubit.toggleType(value: AdminType.category);
                      },
                      selected: cubit.type == AdminType.category,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height(35),
              ),
              cubit.type != AdminType.category
                  ? cubit.type == AdminType.flyers
                      ? AddFlyerWidget(
                        formkey: _formkey2,
                      )
                      : AddStoresWidget(
                          formkey: _formkey1,
                        )
                  : AddCategoryWidget(
                      formkey: _formkey,
                    ),
            ],
          ),
        )),
      );
    });
  }
}

/*class AddStoresFlyersLayout extends StatelessWidget {
  const AddStoresFlyersLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFlyerCubit, AddFlyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AddFlyerCubit cubit = AddFlyerCubit.get(context);
          return Expanded(
            child: PageView.builder(
              controller: cubit.controller,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit.steps.length,
              itemBuilder: (BuildContext context, int no) {
                return cubit.steps[no];
              },
            ),
          );
        });
  }
}*/
