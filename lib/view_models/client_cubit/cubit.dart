import 'package:flyerdeal/services/auth_service.dart';
import 'package:flyerdeal/view_models/client_cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/views/client_views/home_view.dart';
import 'package:flyerdeal/views/client_views/profile_view.dart';
import 'package:flyerdeal/views/client_views/stores_view.dart';
import 'package:flyerdeal/views/client_views/wishlist_view.dart';

class ClientCubit extends Cubit<ClientStates> {
  ClientCubit() : super(ClientStates());

  static ClientCubit get(context) => BlocProvider.of(context);
  List<Widget> views = [
    HomeView(),
    StoresView(),
    WishListView(),
    ProfileView(),
  ];

  int index = 0;

  chooseBottomNavIndex(int value) {
    index = value;
    emit(OnChangeBottomNavIndex(
      index: value,
    ));
  }
}
