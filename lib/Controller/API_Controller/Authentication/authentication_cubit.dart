import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafiil_hiring_app/Const/Api_url.dart';
import 'package:kafiil_hiring_app/Const/constants.dart';
import 'package:kafiil_hiring_app/Model/login_model.dart';
import 'package:kafiil_hiring_app/Model/profile_model.dart';
import 'package:kafiil_hiring_app/helper/cache_helper.dart';
import 'package:kafiil_hiring_app/helper/dio_helper.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  static AuthenticationCubit get(context) => BlocProvider.of(context);
  File? image;

  chooseImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    emit(ChooseImageState());
  }

  LoginModel? loginModel;

  void login({
    Function()? onError,
    Function()? onSuccess,
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: ApiUrl.login,
      data: {
        "email": email.trim(),
        "password": password,
      },
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Login success");
        loginModel = LoginModel.fromJson(value.data);
        CacheHelper.saveData(key: "token", value: loginModel!.accessToken);
        onSuccess!();
      } else {
        onError!();
      }
      emit(LoginSuccessState());
    }).catchError((e) {
      emit(LoginErrorState());
      print(e.toString());
    });
  }

  void register({
    Function()? onError,
    Function()? onSuccess,
  }) async {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: ApiUrl.register,
      data: {},
      containImage: true,
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Register success");
        onSuccess!();
      } else {
        onError!();
      }
      emit(RegisterSuccessState());
    }).catchError((e) {
      emit(RegisterErrorState());
      print(e.toString());
    });
  }

  ProfileModel? profileModel;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var dateController = TextEditingController();
  var aboutController = TextEditingController();
  var salaryController = TextEditingController();
  int profileUserType=1;
  int gender=0;

  void getProfile({
    Function()? onError,
    Function()? onSuccess,
  }) async {
    emit(ProfileLoadingState());
    DioHelper.getData(url: ApiUrl.profile, token: token).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        profileModel = ProfileModel.fromJson(value.data);
        firstNameController.text = profileModel!.data.firstName;
        lastNameController.text = profileModel!.data.lastName;
        emailController.text = profileModel!.data.email;
        dateController.text = profileModel!.data.birthDate;
        salaryController.text = profileModel!.data.salary.toString();
        aboutController.text = profileModel!.data.about;
        passwordController.text = "************";
        profileUserType = profileModel!.data.type.code;
        gender = profileModel!.data.gender;
        print("get Profile success");
        onSuccess!();
      } else {
        onError!();
      }
      emit(ProfileSuccessState());
    }).catchError((e) {
      emit(ProfileErrorState());
      print(e.toString());
    });
  }
}
