import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/category_model.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
import 'package:flyerdeal/services/file_service.dart';
import 'package:flyerdeal/services/flyer_service.dart';
import 'package:flyerdeal/view_models/add_flyer_cubit/states.dart';
import 'package:flyerdeal/widgets/add_flyer_widget.dart';
import 'package:flyerdeal/widgets/add_store_widget.dart';

class AddFlyerCubit extends Cubit<AddFlyerStates> {
  AddFlyerCubit() : super(AddFlyerStates());

  static AddFlyerCubit get(context) => BlocProvider.of(context);
  final FileService _fileService = FileService();
  final FlyerService _flyerService = FlyerService();
  StoreModel storeModel = StoreModel.instance();
  FlyerModel flyerModel = FlyerModel.instance();
  CategoryModel categoryModel = CategoryModel.instance();

  AdminType type = AdminType.flyers;
  List<CategoryModel> categories = [];
  List<StoreModel> stores = [];
  File? storeImage;
  File? flyerPdf;
  File? flyerImage;

  /*onBackStep() {
    controller.previousPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onNextStep() {
    controller.nextPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }*/

  getCategories() {
    emit(GetCategoryLoadingState());
    _flyerService.getCategories().then((value) {
      categories = value;
      emit(GetCategorySuccessState());
    }).catchError((error) {
      emit(GetCategoryErrorState());
    });
  }

  getStores() {
    emit(GetStoresLoadingState());
    _flyerService.getStores().then((value) {
      stores = value;
      emit(GetStoresSuccessState());
    }).catchError((error) {
      emit(GetStoresErrorState());
    });
  }

  toggleType({required AdminType value}) {
    type = value;
    emit(OnChangeFlyerState());
  }

  chooseStoreImage(File file) async {
    storeImage = file;
    emit(OnChangeFlyerState());
  }

  chooseFlyerPdf(File file) async {
    flyerPdf = file;
    emit(OnChangeFlyerState());
  }

  chooseFlyerImage(File file) async {
    flyerImage = file;
    emit(OnChangeFlyerState());
  }

  chooseStoreName(String value) async {
    storeModel.name = value;
    emit(OnChangeFlyerState());
  }

  chooseStore(StoreModel value) async {
    storeModel = value;
    emit(OnChangeFlyerState());
  }

  chooseFlyerName(String value) async {
    flyerModel.name = value;
    emit(OnChangeFlyerState());
  }

  chooseFromDate({required BuildContext context}) async {
    flyerModel.from = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    emit(OnChangeFlyerState());
  }

  chooseToDate({required BuildContext context}) async {
    flyerModel.to = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    emit(OnChangeFlyerState());
  }

  chooseCategory(String value) async {
    categoryModel.key = value;
    emit(OnChangeFlyerState());
  }

  chooseStoreCategory(CategoryModel value) async {
    storeModel.category = value.key;
    emit(OnChangeFlyerState());
  }

  addCategory() {
    emit(AddCategoryLoadingState());
    _flyerService.addCategory(category: categoryModel).then((value) {
      emit(AddCategorySuccessState());
    }).catchError((error) {
      emit(AddCategoryErrorState());
    });
  }

  chooseStoreWebsite(String value) async {
    storeModel.website = value;
    emit(OnChangeFlyerState());
  }

  uploadProfilePicture() async {
    if (storeImage != null && storeModel.image == null) {
      await _fileService.uploadFile(storeImage!).then((value) {
        storeModel.image = value;
      }).catchError((error) {
        printLn(error);
      });
    }
  }

  uploadFlyerImage() async {
    if (flyerImage != null && flyerModel.image == null) {
      await _fileService.uploadFile(flyerImage!).then((value) {
        flyerModel.image = value;
      }).catchError((error) {
        printLn(error);
      });
    }
  }

  uploadFlyerPdf() async {
    if (flyerPdf != null && flyerModel.flyerPdf == null) {
      await _fileService.uploadFile(flyerPdf!).then((value) {
        flyerModel.flyerPdf = value;
      }).catchError((error) {
        printLn(error);
      });
    }
  }

  addFlyer() async {
    flyerModel.store = storeModel;
    emit(AddFlyerLoadingState());
    await uploadFlyerPdf();
    await uploadFlyerImage();
    _flyerService.addFlyer(flyerModel: flyerModel).then((value) {
      emit(AddFlyerSuccessState());
    }).catchError((error) {
      emit(AddFlyerErrorState());
    });
  }

  addStore() async {
    emit(AddStoreLoadingState());
    await uploadProfilePicture();
    _flyerService.addStore(storeModel: storeModel).then((value) {
      emit(AddStoreSuccessState());
    }).catchError((error) {
      emit(AddStoreErrorState());
    });
  }
}
