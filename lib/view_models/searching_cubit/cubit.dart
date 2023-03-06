import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/view_models/searching_cubit/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<FlyerModel> searchedList = [];

  String? category = "foods";

  changeCategory({required String value, required List<FlyerModel> flyers}) {
    category = value;
    filterList(flyers: flyers);
    emit(OnCategoryChange());
  }

  void filterList({required List<FlyerModel> flyers}) {
    final List<FlyerModel> filteredItems =
        flyers.where((item) => item.category == category).toList();
    searchedList = filteredItems;
    emit(OnChangeState());
  }

  // Define a function that searches the list based on a name
  void searchList({required String query, required List<FlyerModel> flyers}) {
    final List<FlyerModel> searchedItems = flyers
        .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    searchedList = searchedItems;
    emit(OnChangeState());
  }
}
