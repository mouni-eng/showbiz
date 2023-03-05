import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigateTo({required Widget view, required BuildContext context}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}
