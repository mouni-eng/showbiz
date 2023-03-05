import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/user_model.dart';
import 'package:flyerdeal/services/auth_service.dart';
import 'package:flyerdeal/services/file_service.dart';
import 'package:flyerdeal/services/language_service.dart';
import 'package:flyerdeal/view_models/auth_cubit/states.dart';
import 'package:flyerdeal/views/AuthViews/RegisterViews/additional_data_view.dart';
import 'package:flyerdeal/views/AuthViews/RegisterViews/personal_data_view.dart';
import 'package:flyerdeal/views/AuthViews/RegisterViews/verify_otp_view.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final FileService _fileService = FileService();
  final AuthService _authService = AuthService();

  File? profileImage;
  UserModel signUpRequest = UserModel.instance();

  int index = 0;
  bool isLast = false;
  double percent = 1 / 3;

  PageController controller = PageController();
  String? pin;
  String? verficationId;

  List<String>headersData(context) {
    return [
    translation(context).personalData,
    translation(context).accountData,
    translation(context).verifyyouremail,
  ];
  }

  List<Widget> steps = [
    PersonalDataView(),
    AdditionalDataView(),
    VerifyOtpView(),
  ];



  onBackStep() {
    if (percent != 1 / 3) {
      percent -= 1 / 3;
      index -= 1;
      isLast = false;
      emit(OnBackRegistrationStep());
    }

    controller.previousPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onNextStep() {
    if (percent != 1) {
      percent += 1 / 3;
      index += 1;
      if (index == 2) {
        isLast = true;
      }
      emit(OnNextRegistrationStep());
    }
    controller.nextPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  chooseImage(File file) async {
    profileImage = file;
    emit(ChooseProfileImageState());
  }

  onChangeName(String value) {
    signUpRequest.name = value;
    emit(OnChangeState());
  }

  onChangeCategory(UserRole value) {
    signUpRequest.role = value;
    emit(OnChangeState());
  }

  onChangeSurName(String value) {
    signUpRequest.surname = value;
    emit(OnChangeState());
  }

  onChangePhoneNumber(String value) {
    signUpRequest.phoneNumber = value;
    emit(OnChangeState());
  }

  onChangeBirthDate(DateTime value) {
    signUpRequest.birthdate = value;
    emit(OnChangeState());
  }

  onChangeUserName(String value) {
    signUpRequest.username = value;
    emit(OnChangeState());
  }

  onChangeEmailAddress(String value) {
    signUpRequest.email = value;
    emit(OnChangeState());
  }

  onChangePassword(String value) {
    signUpRequest.password = value;
    emit(OnChangeState());
  }

  onChangeConfirmPassword(String value) {
    signUpRequest.confirmPassword = value;
    emit(OnChangeState());
  }

  onChangePin(String value) {
    pin = value;
    emit(OnChangeState());
  }

  verficationIdChanged(String value) {
    verficationId = value;
    emit(OnChangeState());
  }

  logIn() {
    
      emit(LogInLoadingState());
      _authService
          .login(email: signUpRequest.email, password: signUpRequest.password)
          .then((value) {
        emit(LogInSuccessState());
      }).catchError((error) {
        emit(LogInErrorState(error: error.toString()));
      });
  }

  saveUser() {
    emit(RegisterLoadingState());
    _authService.register(model: signUpRequest).then((value) async {
      signUpRequest.role = UserRole.client;
      await uploadProfilePicture();
      _authService.saveUser(model: signUpRequest);
    }).then((value) {
      onNextStep();
      verifyPhoneNumber();
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error: error.message));
    });
  }

  uploadProfilePicture() async {
    if (profileImage != null && signUpRequest.profilePictureId == null) {
      await _fileService.uploadFile(profileImage!).then((value) {
        signUpRequest.profilePictureId = value;
      }).catchError((error) {
        printLn(error);
      });
    }
  }

  verifyPhoneNumber() {
    _authService.verfiyPhoneNumber(
        phoneNumber: signUpRequest.phoneNumber,
        onSent: (String vId, int? token) {
          verficationIdChanged(vId);
          emit(CodeSentState());
        });
  }

  Future<void> confirmOtp() async {
    emit(OtpConfirmedLoadingState());
    _authService.confirmOtp(vId: verficationId!, code: pin).then((value) {
      emit(OtpConfirmedSuccessState());
    }).catchError((error) {
      emit(OtpConfirmedErrorState(error: error.message));
    });
  }
}
