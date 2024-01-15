import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_hiring_app/View/Screens/Authentication/CompleteDataScreen.dart';
import 'package:kafiil_hiring_app/View/Screens/Authentication/countriess_screen.dart';
import 'package:kafiil_hiring_app/View/Screens/Authentication/login_screen.dart';
import 'package:kafiil_hiring_app/View/Screens/profile_screen.dart';
import 'package:kafiil_hiring_app/View/Screens/services_screen.dart';
import 'package:meta/meta.dart';

part 'app_controller_state.dart';

class AppControllerCubit extends Cubit<AppControllerState> {
  AppControllerCubit() : super(AppControllerInitial());

  static AppControllerCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  bool showConfirmPassword = true;
  bool rememberMe = false;
  bool validate = false;
  int userType = 1;
  String gender = 'Male';
  bool facebook = false;
  bool instagram = false;
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
  List<Widget> bottomScreens = const [
    ProfileScreen(),
    CountriesScreen(),
    ServicesScreen(),

  ];

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }
}
