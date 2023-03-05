import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/view_models/stores_cubit/states.dart';

class StoreCubit extends Cubit<StoresStates> {
  StoreCubit() : super(StoresStates());

  static StoreCubit get(context) => BlocProvider.of(context);

  String category = "Office & Tables";

  List<String> categories = [
    "Electronics",
    "Grocery",
    "Automotive",
    "Clothing",
    "Pharmacy",
    "Black Friday",
    "Jewellery",
    "Wholesale",
    "Christmas",
    "Banks",
  ];

  changeCategory(String value) {
    category = value;
    emit(OnChangeState());
  }

  List<StoreModel> stores = [
    storeModel,
    storeModel,
    storeModel,
    storeModel,
    storeModel,
  ];
}
