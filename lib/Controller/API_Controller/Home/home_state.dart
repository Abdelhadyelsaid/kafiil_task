part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

///Profile
class ProfileLoadingState extends HomeState {}

class ProfileSuccessState extends HomeState {}

class ProfileErrorState extends HomeState {}

///Service
class ServiceLoadingState extends HomeState {}

class ServiceSuccessState extends HomeState {}

class ServiceErrorState extends HomeState {}

///Popular
class PopularLoadingState extends HomeState {}

class PopularSuccessState extends HomeState {}

class PopularErrorState extends HomeState {}
