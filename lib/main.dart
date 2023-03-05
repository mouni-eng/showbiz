import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flyerdeal/services/local/cache_helper.dart';
import 'package:flyerdeal/services/notification_service.dart';
import 'package:flyerdeal/view_models/Favourites_cubit/cubit.dart';
import 'package:flyerdeal/view_models/add_flyer_cubit/cubit.dart';
import 'package:flyerdeal/view_models/admin_cubit/cubit.dart';
import 'package:flyerdeal/view_models/admin_home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/app_cubit/cubit.dart';
import 'package:flyerdeal/view_models/app_cubit/states.dart';
import 'package:flyerdeal/view_models/client_cubit/cubit.dart';
import 'package:flyerdeal/view_models/home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/location_cubit/cubit.dart';
import 'package:flyerdeal/view_models/notification_cubit/cubit.dart';
import 'package:flyerdeal/view_models/onBoarding_cubit/cubit.dart';
import 'package:flyerdeal/view_models/profile_cubit/cubit.dart';
import 'package:flyerdeal/view_models/profile_cubit/states.dart';
import 'package:flyerdeal/view_models/searching_cubit/cubit.dart';
import 'package:flyerdeal/view_models/stores_cubit/cubit.dart';
import 'package:flyerdeal/views/AuthViews/LoginViews/login_view.dart';
import 'package:flyerdeal/views/admin_views/admin_layout.dart';
import 'package:flyerdeal/views/client_views/layout_screen.dart';
import 'view_models/auth_cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final notificationCubit = NotificationCubit();

  // Configure FirebaseMessagingService with the NotificationCubit
  FirebaseMessagingService.instance.configure(
    notificationCubit: notificationCubit,
  );
  await CacheHelper.init();
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
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => LocationCubit()..fetchData()),
        BlocProvider(create: (_) => OnBoardingCubit()),
        BlocProvider(create: (_) => StoreCubit()),
        BlocProvider(create: (_) => FavouritesCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => NotificationCubit()),
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
                          home: AdminLayoutView(),
                        );
                      });
                });
          }),
    );
  }
}
