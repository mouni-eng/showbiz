import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/services/language_service.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/custom_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../view_models/auth_cubit/cubit.dart';
import '../../../view_models/auth_cubit/states.dart';

class UserRegistrationLayout extends StatelessWidget {
  const UserRegistrationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width(24),
                  vertical: height(24),
                ),
                child: BlocConsumer<AuthCubit, AuthStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      AuthCubit cubit = AuthCubit.get(context);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              color: color.hintColor,
                              fontSize: width(22),
                              fontWeight: FontWeight.w600,
                              text: cubit.headersData(context)[cubit.index]),
                          SizedBox(
                            height: height(5),
                          ),
                          Row(
                            children: [
                              CustomText(
                                  color: color.primaryColor,
                                  fontSize: width(16),
                                  fontWeight: FontWeight.w600,
                                  text: "${translation(context).step} ${cubit.index + 1}"),
                              CustomText(
                                  color: color.hintColor,
                                  fontSize: width(16),
                                  text: " ${translation(context).to} 3 "),
                            ],
                          ),
                          SizedBox(
                            height: height(14),
                          ),
                          LinearPercentIndicator(
                            width: width(320),
                            lineHeight: height(5),
                            animation: true,
                            barRadius: const Radius.circular(6),
                            percent: cubit.percent,
                            padding: EdgeInsets.zero,
                            backgroundColor: color.backgroundColor,
                            progressColor: color.primaryColor,
                          ),
                          SizedBox(
                            height: height(30),
                          ),
                          Expanded(
                            child: PageView.builder(
                              controller: cubit.controller,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.steps.length,
                              itemBuilder: (BuildContext context, int no) {
                                return cubit.steps[no];
                              },
                            ),
                          ),
                        ],
                      );
                    }))));
  }
}
