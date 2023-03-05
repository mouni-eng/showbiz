import 'package:flyerdeal/services/auth_service.dart';
import 'package:flyerdeal/view_models/admin_cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/views/admin_views/add_store_Layout_view.dart';
import 'package:flyerdeal/views/admin_views/admin_home_view.dart';
import 'package:flyerdeal/views/client_views/profile_view.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminStates());

  static AdminCubit get(context) => BlocProvider.of(context);
  List<Widget> views = [
    AdminHomeView(),
    AddStoreFlyerView(),
    ProfileView(),
  ];

  int index = 0;

  chooseAdminBottomNavIndex(int value) {
    index = value;
    emit(OnChangeAdminBottomNavIndex(
      index: value,
    ));
  }
}
