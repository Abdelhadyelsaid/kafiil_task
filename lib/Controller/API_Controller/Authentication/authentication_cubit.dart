import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafiil_hiring_app/Const/Api_url.dart';
import 'package:kafiil_hiring_app/Controller/API_Controller/Home/home_cubit.dart';
import 'package:kafiil_hiring_app/Model/login_model.dart';
import 'package:kafiil_hiring_app/helper/cache_helper.dart';
import 'package:kafiil_hiring_app/helper/dio_helper.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  File? image;

  chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
  }) async{
    emit(LoginLoadingState());
    DioHelper.postData(
      url: ApiUrl.login,
      data: {
        "email": email,
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

}
