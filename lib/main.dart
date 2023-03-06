import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flyerdeal/models/notification_model.dart';
import 'package:flyerdeal/services/local/cache_helper.dart';
import 'package:flyerdeal/services/local/notify_databse_helper.dart';
import 'package:flyerdeal/view_models/add_flyer_cubit/cubit.dart';
import 'package:flyerdeal/view_models/admin_cubit/cubit.dart';
import 'package:flyerdeal/view_models/admin_home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/app_cubit/cubit.dart';
import 'package:flyerdeal/view_models/app_cubit/states.dart';
import 'package:flyerdeal/view_models/bloc_observer.dart';
import 'package:flyerdeal/view_models/client_cubit/cubit.dart';
import 'package:flyerdeal/view_models/home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/location_cubit/cubit.dart';
import 'package:flyerdeal/view_models/notification_cubit/cubit.dart';
import 'package:flyerdeal/view_models/profile_cubit/cubit.dart';
import 'package:flyerdeal/view_models/profile_cubit/states.dart';
import 'package:flyerdeal/view_models/searching_cubit/cubit.dart';
import 'package:flyerdeal/view_models/wishlist_cubit/cubit.dart';
import 'view_models/auth_cubit/cubit.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _showNotification(RemoteMessage message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    UniqueKey().hashCode.toString(),
    'Showbiz',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
      message.notification!.body, platformChannelSpecifics,
      payload: message.data['data']);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("onMessage: ${message.notification?.title}");
    _showNotification(message);
    var dbHelper = NotificationDatbaseHelper.db;
    dbHelper
        .insert(NotificationModel(
      title: message.notification?.title,
      subTitle: message.notification?.body,
    ))
        .then((value) {
      print("success");
    }).catchError((error) {
      print(error.toString());
    });
  });
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppCubit()..getCurrentLocale()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ClientCubit()),
        BlocProvider(create: (_) => AdminCubit()),
        BlocProvider(create: (_) => AdminHomeCubit()..getAllData()),
        BlocProvider(create: (_) => AddFlyerCubit()),
        BlocProvider(create: (_) => HomeCubit()..getAllFlyers()),
        BlocProvider(create: (_) => LocationCubit()..fetchData()),
        BlocProvider(create: (_) => WishListCubit()..getAllFavourites()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => NotificationCubit()..loadNotifications()),
      ],
      child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, states) {},
          builder: (context, states) {
            var profileCubit = ProfileCubit.get(context);
            return BlocConsumer<AppCubit, AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = AppCubit.get(context);
                  return ConditionalBuilder(
                      condition: state is! GetLocaleLoadingState &&
                          state is! GetUserLoadingState,
                      fallback: (context) => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                      builder: (context) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'flyerdeals',
                          locale: cubit.locale,
                          localizationsDelegates:
                              AppLocalizations.localizationsDelegates,
                          supportedLocales: AppLocalizations.supportedLocales,
                          theme: profileCubit.theme,
                          home: cubit.currentView(),
                        );
                      });
                });
          }),
    );
  }
}
