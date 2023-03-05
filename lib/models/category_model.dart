class CategoryModel {
  String? key;

  CategoryModel.instance();

  CategoryModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        
      };
}
