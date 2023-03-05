import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          if (state is NotificationInitial) {
            return const Center(
              child: Text('No notifications'),
            );
          } else if (state is NotificationLoaded) {
            return ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];
                return ListTile(
                  title: Text(message.notification?.title ?? ''),
                  subtitle: Text(message.notification?.body ?? ''),
                );
              },
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
