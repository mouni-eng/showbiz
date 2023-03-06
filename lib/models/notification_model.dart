class NotificationModel {
  String? title, subTitle;

  NotificationModel({required this.title, required this.subTitle});

  NotificationModel.fromJson(Map<dynamic, dynamic> map) {
    title = map['title'];
    subTitle = map['subTitle'];
  }

  toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
    };
  }
}
