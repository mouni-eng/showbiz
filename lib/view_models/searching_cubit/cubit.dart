import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/view_models/searching_cubit/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<FlyerModel> searchedList = [];
}
