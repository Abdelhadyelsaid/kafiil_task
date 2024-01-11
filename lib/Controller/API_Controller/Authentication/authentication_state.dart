part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class ChooseImageState extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {}

class LoginErrorState extends AuthenticationState {}
