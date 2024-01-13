part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class ChooseImageState extends AuthenticationState {}

///Login
class LoginLoadingState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {}

class LoginErrorState extends AuthenticationState {}

///register
class RegisterLoadingState extends AuthenticationState {}

class RegisterSuccessState extends AuthenticationState {}

class RegisterErrorState extends AuthenticationState {}

///Profile
class ProfileLoadingState extends AuthenticationState {}

class ProfileSuccessState extends AuthenticationState {}

class ProfileErrorState extends AuthenticationState {}