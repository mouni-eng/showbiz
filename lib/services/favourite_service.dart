import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';

class FavouriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToFavourite({required FlyerModel flyerModel}) async {
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(favRef)
        .doc(flyerModel.id)
        .set(flyerModel.toJson());
  }

  Future<void> removeFavourite({required FlyerModel flyerModel}) async {
    await _firestore.collection(userRef)
        .doc(userModel?.personalId)
        .collection(favRef).doc(flyerModel.id).delete();
  }

  Future<List<FlyerModel>> getAllFav() async {
    List<FlyerModel> favs = [];
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(favRef)
        .get()
        .then((value) {
      for (var favourite in value.docs) {
        favs.add(FlyerModel.fromJson(favourite.data()));
      }
    });

    return favs;
  }

  Future<void> addToStoreFavourite({required StoreModel storeModel}) async {
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(storeFav)
        .doc(storeModel.id)
        .set(storeModel.toJson());
  }

  Future<void> removeStoreFavourite({required StoreModel storeModel}) async {
    await _firestore.collection(userRef)
        .doc(userModel?.personalId)
        .collection(storeFav)
        .doc(storeModel.id).delete();
  }

  Future<List<StoreModel>> getAllStoreFav() async {
    List<StoreModel> favs = [];
    await _firestore
        .collection(userRef)
        .doc(userModel?.personalId)
        .collection(storeFav)
        .get()
        .then((value) {
      for (var favourite in value.docs) {
        favs.add(StoreModel.fromJson(favourite.data()));
      }
    });

    return favs;
  }
}
