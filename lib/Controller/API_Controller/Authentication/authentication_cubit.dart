import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafiil_hiring_app/Const/Api_url.dart';
import 'package:kafiil_hiring_app/Const/constants.dart';
import 'package:kafiil_hiring_app/Model/dependancies_model.dart';
import 'package:kafiil_hiring_app/Model/login_model.dart';
import 'package:kafiil_hiring_app/Model/profile_model.dart';
import 'package:kafiil_hiring_app/helper/cache_helper.dart';
import 'package:kafiil_hiring_app/helper/dio_helper.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  static AuthenticationCubit get(context) => BlocProvider.of(context);
  File? image;
  File? avatarFile;

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
    required String birthDate,
    required String about,
    required int salary,
    required List<dynamic> tags,
    required List<String> socialMedia,
  }) async {
    avatarFile = File(image!.path);
    Map<String, dynamic> data = {
      'first_name': CacheHelper.getData(key: 'firstName'),
      'last_name': CacheHelper.getData(key: 'lastName'),
      'about': about,
      'tags[]': tags,
      'favorite_social_media[]': socialMedia,
      'salary': salary,
      'password': CacheHelper.getData(key: 'password'),
      'email': CacheHelper.getData(key: 'email'),
      'birth_date': birthDate,
      'gender': gender,
      'type': userTypevalue,
      'password_confirmation': CacheHelper.getData(key: 'password'),
    };
    FormData formData = FormData.fromMap(data);
    formData.files.add(
        MapEntry('avatar', await MultipartFile.fromFile(avatarFile!.path)));
    Dio dio = Dio();
    emit(RegisterLoadingState());
    try {
      Response response = await dio.post(
          'https://test.kafiil.com/api/test/user/register',
          data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        print("Register success");
        onSuccess!();
      } else {
        print('Request failed with status: ${response.statusCode}');
        print(response.data);
        onError!();
      }
      emit(RegisterSuccessState());
    } catch (e) {
      print('Error: $e');
    }
  }

  ProfileModel? profileModel;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var dateController = TextEditingController();
  var aboutController = TextEditingController();
  var salaryController = TextEditingController();
  int profileUserType = 1;
  int gender = 0;

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

  DependenciesModel? dependenciesModel;

  late final items;
  List<String> userType=[];
  String? userTypevalue='buyer';

  void getDependacncies({
    Function()? onError,
    Function()? onSuccess,
  }) async {
    emit(DependanciesLoadingState());
    DioHelper.getData(url: ApiUrl.tags, token: token).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        dependenciesModel = DependenciesModel.fromJson(value.data);
        items = dependenciesModel!.data.tags
            .map((tag) => MultiSelectItem<DependTags>(tag, tag.label))
            .toList();
        for(int i=0;i<dependenciesModel!.data.types.length;i++){
          userType.add(dependenciesModel!.data.types[i].label);
        }

        print("get dependencies success");
        onSuccess!();
      } else {
        onError!();
      }
      emit(DependanciesSuccessState());
    }).catchError((e) {
      emit(DependanciesErrorState());
      print(e.toString());
    });
  }
}
