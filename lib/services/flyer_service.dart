import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/category_model.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';

class FlyerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFlyer({required FlyerModel flyerModel}) async {
    await _firestore.collection(flyerRef).doc().set(flyerModel.toJson());
  }

  Future<void> addStore({required StoreModel storeModel}) async {
    await _firestore.collection(storeRef).doc().set(storeModel.toJson());
  }

  Future<void> addCategory({required CategoryModel category}) async {
    await _firestore.collection(categoryRef).doc().set(category.toJson());
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    await _firestore.collection(categoryRef).get().then((value) {
      for (var category in value.docs) {
        categories.add(CategoryModel.fromJson(category.data()));
      }
    });
    return categories;
  }

  Future<List<StoreModel>> getStores() async {
    List<StoreModel> stores = [];
    await _firestore.collection(storeRef).get().then((value) {
      for (var store in value.docs) {
        stores.add(StoreModel.fromJson(store.data()));
      }
    });
    return stores;
  }
}
