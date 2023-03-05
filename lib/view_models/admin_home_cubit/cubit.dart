import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/models/user_model.dart';
import 'package:flyerdeal/services/all_data_service.dart';
import 'package:flyerdeal/view_models/admin_home_cubit/states.dart';

class AdminHomeCubit extends Cubit<AdminHomeStates> {
  AdminHomeCubit() : super(AdminHomeStates());

  static AdminHomeCubit get(context) => BlocProvider.of(context);
  final AllDataService _dataService = AllDataService();

  List<UserModel> users = [];
  List<FlyerModel> flyers = [];
  List<StoreModel> stores = [];

  getAllData() {
    users = [];
    flyers = [];
    stores = [];
    emit(GetAllDataLoadingState());
    _dataService.getAllUsers().then((value) {
      users = value;
      emit(GetAllDataSuccessState());
    }).then((value) {
      _dataService.getAllFlyers().then((value) {
        flyers = value;
        emit(GetAllDataSuccessState());
      }).then((value) {
        _dataService.getAllStores().then((value) {
          stores = value;
          emit(GetAllDataSuccessState());
        });
      });
    }).catchError((error) {
      emit(GetAllDataErrorState());
    });
  }
}
