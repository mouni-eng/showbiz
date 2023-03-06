import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/services/favourite_service.dart';
import 'package:flyerdeal/view_models/wishlist_cubit/states.dart';

class WishListCubit extends Cubit<WishListStates> {
  WishListCubit() : super(WishListStates());

  static WishListCubit get(context) => BlocProvider.of(context);
  final FavouriteService _favouriteService = FavouriteService();

  List<FlyerModel> favourites = [];
  List<StoreModel> stores = [];
  Type favouriteType = Type.flyers;

  changeFavouriteType(Type type) {
    favouriteType = type;
    emit(OnChangeState());
  }

  getAllFavourites() {
    emit(GetWishListLoadingState());
    _favouriteService.getAllFav().then((value) {
      favourites = value;
    }).then((value) {
      getAllStoreFavourites();
      
    }).catchError((error) {
      emit(GetWishListErrorState());
    });
  }

  addFavourites({required FlyerModel flyer}) {
    _favouriteService.addToFavourite(flyerModel: flyer).then((value) {
      getAllFavourites();
    });

    emit(OnAddWishList());
  }

  removeFavourites({required FlyerModel flyer}) {
    _favouriteService.removeFavourite(flyerModel: flyer).then((value) {
      getAllFavourites();
    });

    emit(OnRemoveWishList());
  }

  toogleFavourite({required bool isFavourite, required FlyerModel flyer}) {
    if (isFavourite) {
      removeFavourites(flyer: flyer);
    } else {
      addFavourites(flyer: flyer);
    }
  }

  getAllStoreFavourites() {
    _favouriteService.getAllStoreFav().then((value) {
      stores = value;
      emit(GetWishListSuccessState());
    });
  }

  addStoreFavourites({required StoreModel store}) {
    _favouriteService.addToStoreFavourite(storeModel: store).then((value) {
      getAllStoreFavourites();
    });

    emit(OnAddWishList());
  }

  removeStoreFavourites({required StoreModel store}) {
    _favouriteService.removeStoreFavourite(storeModel: store).then((value) {
      getAllStoreFavourites();
    });

    emit(OnRemoveWishList());
  }

  toogleStoreFavourite({required bool isFavourite, required StoreModel store}) {
    if (isFavourite) {
      removeStoreFavourites(store: store);
    } else {
      addStoreFavourites(store: store);
    }
  }
}
