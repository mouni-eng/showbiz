import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/models/user_model.dart';

class AllDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async{
    List<UserModel> users = [];
    await _firestore.collection(userRef).get().then((value) {
      for (var user in value.docs) {
        users.add(UserModel.fromJson(user.data()));
      }
    });
    return users;
  }

  Future<List<FlyerModel>> getAllFlyers() async{
    List<FlyerModel> flyers = [];
    await _firestore.collection(flyerRef).get().then((value) {
      for (var flyer in value.docs) {
        flyers.add(FlyerModel.fromJson(flyer.data()));
      }
    });
    return flyers;
  }

  Future<List<StoreModel>> getAllStores() async{
    List<StoreModel> stores = [];
    await _firestore.collection(storeRef).get().then((value) {
      for (var store in value.docs) {
        stores.add(StoreModel.fromJson(store.data()));
      }
    });
    return stores;
  }
}
