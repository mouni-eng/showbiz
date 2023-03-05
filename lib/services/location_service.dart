import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/address.dart';
import 'package:flyerdeal/models/user_model.dart';
import 'package:flyerdeal/services/local/cache_helper.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateLocation({required Address address,}) async {
    String uid = CacheHelper.getData(key: "uid");
    printLn(uid);
    printLn(address.street2.toString());
    await _firestore
        .collection(userRef)
        .doc(uid)
        .update({"address": address.toJson()});
  }

}
