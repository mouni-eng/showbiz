import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/cached_image.dart';
import 'package:flyerdeal/widgets/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class CircleImage extends StatelessWidget {
  final String? imageSrc;
  final String avatarLetters;
  final double width, height;

  const CircleImage({
    Key? key,
    required this.imageSrc,
    required this.avatarLetters,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return imageSrc != null && imageSrc!.isNotEmpty
        ? SizedBox(
            width: width,
            height: height,
            child: CustomCachedImage(
              url: imageSrc!,
              imageType: RentXImageType.local,
              boxFit: BoxFit.fill,
              boxShape: BoxShape.circle,
            ),
          )
        : SizedBox(
            width: width,
            height: height,
            child: CircleAvatar(
              backgroundColor: color.primaryColor,
              child: CustomText(
                text: avatarLetters,
                maxlines: 1,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color.primaryColorLight,
              ),
            ),
          );
  }
}

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker(
      {Key? key,
      required this.widgetBuilder,
      required this.onFilePick,
      this.showOnLongPress = false,
      this.isPdf = false})
      : super(key: key);

  final Widget Function() widgetBuilder;
  final Function(File) onFilePick;
  final bool? showOnLongPress, isPdf;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showOnLongPress! ? _showBottomSheet(context) : null,
      onTap: () => showOnLongPress! ? null : _showBottomSheet(context),
      child: widgetBuilder.call(),
    );
  }

  void _showBottomSheet(BuildContext context) {
    var color = Theme.of(context);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext buildContext) {
          return Container(
            decoration: BoxDecoration(
                color: color.backgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (isPdf == false)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _getFromCamera(context),
                              icon: const Icon(Icons.camera),
                              tooltip: 'Test',
                              color: color.primaryColor,
                            ),
                            CustomText(
                              text: 'camera',
                              fontSize: width(12),
                            )
                          ],
                        ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => !isPdf!
                                  ? _getFromGallery(context)
                                  : _getPdf(context),
                              icon: const Icon(Icons.image_sharp),
                              color: color.primaryColor),
                          CustomText(
                            text: 'gallery',
                            fontSize: width(12),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery(BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      onFilePick.call(File(pickedFile.path));
      Navigator.of(context).pop();
    }
  }

  _getPdf(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      onFilePick.call(File(result.files.single.path!));
      Navigator.of(context).pop();
    }
  }

  /// Get from Camera
  _getFromCamera(BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      onFilePick.call(File(pickedFile.path));
      Navigator.of(context).pop();
    }
  }
}
