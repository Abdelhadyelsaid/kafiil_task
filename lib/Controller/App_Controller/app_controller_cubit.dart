import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_hiring_app/View/Screens/CompleteDataScreen.dart';
import 'package:kafiil_hiring_app/View/Screens/login_screen.dart';
import 'package:meta/meta.dart';

part 'app_controller_state.dart';

class AppControllerCubit extends Cubit<AppControllerState> {
  AppControllerCubit() : super(AppControllerInitial());

  static AppControllerCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  bool showConfirmPassword = true;
  bool rememberMe = false;
  bool validate = false;
  String userType = 'Seller';
  String gender = 'Male';
  bool facebook = false;
  bool linkedIn = false;
  bool twitter = false;

  void switchPasswordVisibility() {
    showPassword = !showPassword;
    emit(SwitchPasswordVisibilityState());
  }

  void switchErrorMessageVisibility() {
    validate = !validate;
    emit(showErrorMessageState());
  }

  void RemoveErrorMessage() {
    emit(RemoveErrorMessageState());
  }

  void switchConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    emit(SwitchConfirmPasswordVisibilityState());
  }

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    CompleteDataScreen(),
    LoginScreen(),
    CompleteDataScreen(),
  ];

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }
}