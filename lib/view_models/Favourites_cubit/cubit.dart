import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/view_models/Favourites_cubit/states.dart';

class FavouritesCubit extends Cubit<FavouritesStates> {
  FavouritesCubit() : super(FavouritesStates());

  static FavouritesCubit get(context) => BlocProvider.of(context);

  Type favouriteType = Type.flyers;

  List<FlyerModel> flyers = [
    flyerModel,
    flyerModel,
    flyerModel,
  ];
  List<StoreModel> stores = [
    storeModel,
    storeModel,
    storeModel,
    storeModel,
  ];

  changeFavouriteType(Type type) {
    favouriteType = type;
    emit(OnChangeState());
  }
}
