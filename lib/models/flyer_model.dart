import 'package:flyerdeal/models/store_model.dart';

class FlyerModel {
  String? name, category, image, flyerPdf;
  StoreModel? store;
  DateTime? from, to;

  FlyerModel.instance();

  FlyerModel({
    required this.name,
    required this.category,
    required this.image,
    required this.store,
    required this.from,
    required this.to,
    required this.flyerPdf,
  });

  FlyerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    image = json['image'];
    flyerPdf = json['flyerPdf'];
    from = json['from'].toDate();
    to = json['to'].toDate();
    store = StoreModel.fromJson(json['store']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': store!.category,
        'image': image,
        'flyerPdf': flyerPdf,
        'from': from ?? from?.toIso8601String(),
        'to': to ?? to?.toIso8601String(),
        'store': store!.toJson(),
      };
}

enum Type { flyers, stores }

enum AdminType { flyers, stores, category }
