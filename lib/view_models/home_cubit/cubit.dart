import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/view_models/home_cubit/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);

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

  String category = "Office & Tables";

  changeCategory(String value) {
    category = value;
    emit(OnCategoryChange());
  }
}
