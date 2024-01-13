part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}



///Service
class ServiceLoadingState extends HomeState {}

class ServiceSuccessState extends HomeState {}

class ServiceErrorState extends HomeState {}

///Popular
class PopularLoadingState extends HomeState {}

class PopularSuccessState extends HomeState {}

class PopularErrorState extends HomeState {}
///Country
class CountryLoadingState extends HomeState {}

class CountrySuccessState extends HomeState {}

class CountryErrorState extends HomeState {}