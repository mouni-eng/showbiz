class StoreModel {
  String? name, category, image, website;
  

  StoreModel.instance();

  StoreModel({
    required this.name,
    required this.category,
    required this.image,
    required this.website,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    image = json['image'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'image': image,
        'website': website,
      };
}
