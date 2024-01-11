part of 'app_controller_cubit.dart';

@immutable
abstract class AppControllerState {}

class AppControllerInitial extends AppControllerState {}

class SwitchPasswordVisibilityState extends AppControllerState {}

class SwitchConfirmPasswordVisibilityState extends AppControllerState {}

class ChangeNavBarState extends AppControllerState {}

class ChangeRememberMeState extends AppControllerState {}

class showErrorMessageState extends AppControllerState {}

class RemoveErrorMessageState extends AppControllerState {}
