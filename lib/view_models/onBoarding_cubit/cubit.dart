import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/models/onBoarding_model.dart';
import 'package:flyerdeal/view_models/onBoarding_cubit/states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingStates());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  PageController controller = PageController();

  bool isLast = false;

  int index = 0;

  onChangeIndex(int value) {
    index = value;
    emit(OnNextRegistrationStep());
  }

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      title: "ألثوريه",
      image: "assets/images/welcome.svg",
      subTitle:
          "الثوريه هي شركة أمن محلية واردة ، تقع في المملكة العربية السعودية",
    ),
    OnBoardingModel(
      title: "تطبيق التجارة الإلكترونية عبر الإنترنت",
      image: "assets/images/booking.svg",
      subTitle: "استكشف معدات الأمان الأكثر مبيعا لدينا ، لدينا عروض رائعة لك",
    ),
    OnBoardingModel(
      title: "احجز فني التركيب الخاص بك",
      image: "assets/images/tracking.svg",
      subTitle:
          "نحن نقدم خدمة تثبيت رائعة يمكنك من خلالها حجز وتتبع خدمة التثبيت الخاصة بك",
    ),
  ];

  onBackStep() {
    index -= 1;
    isLast = false;
    emit(OnBackRegistrationStep());

    controller.previousPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onNextStep() {
    index += 1;
    if (index == 2) {
      isLast = true;
    }
    emit(OnNextRegistrationStep());
    controller.nextPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }
}
