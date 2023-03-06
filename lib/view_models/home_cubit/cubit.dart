import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/models/category_model.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/services/all_data_service.dart';
import 'package:flyerdeal/view_models/home_cubit/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  final AllDataService _dataService = AllDataService();

  List<CategoryModel> categories = [];
  List<FlyerModel> flyers = [];
  List<FlyerModel> filterdFlyers = [];
  List<StoreModel> stores = [];
  List<StoreModel> filterdStores = [];

  String? category;

  changeCategory(String value) {
    category = value;
    filterFlyerList();
    filterStoreList();
    emit(OnCategoryChange());
  }

  getAllFlyers() {
    emit(GetAllFlyersLoading());
    _dataService.getAllFlyers().then((value) {
      flyers = value;
      emit(GetAllFlyersSuccess());
    }).then((value) {
      getAllCategories();
    }).catchError((error) {
      emit(GetAllFlyersError());
    });
  }

  getAllCategories() {
    emit(GetAllCategoriesLoading());
    _dataService.getAllCategories().then((value) {
      categories = value;
      print(categories[0].key);
      emit(GetAllCategoriesSuccess());
    }).catchError((error) {
      emit(GetAllCategoriesError());
    });
  }

  getAllStores() {
    emit(GetAllStoresLoading());
    _dataService.getAllStores().then((value) {
      stores = value;
      emit(GetAllStoresSuccess());
    }).then((value) {
      getAllCategories();
    }).catchError((error) {
      emit(GetAllStoresError());
    });
  }

  void filterFlyerList() {
    final List<FlyerModel> filteredItems =
        flyers.where((item) => item.category == category).toList();
    filterdFlyers = filteredItems;
    print(filteredItems.length);
    print(category);
    emit(OnChangeState());
  }

  void filterStoreList() {
    final List<StoreModel> filteredItems =
        stores.where((item) => item.category == category).toList();
    filterdStores = filteredItems;
    print(filteredItems.length);
    print(category);
    emit(OnChangeState());
  }
}
