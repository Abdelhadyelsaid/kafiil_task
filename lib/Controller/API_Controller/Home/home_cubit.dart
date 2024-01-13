import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_hiring_app/Const/Api_url.dart';
import 'package:kafiil_hiring_app/Model/countries_model.dart';
import 'package:kafiil_hiring_app/Model/popular_services_model.dart';
import 'package:kafiil_hiring_app/Model/services_model.dart';
import 'package:kafiil_hiring_app/helper/dio_helper.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  Services? services;

  void getService({
    Function()? onError,
    Function()? onSuccess,
  }) async {
    emit(ServiceLoadingState());
    DioHelper.getData(
      url: ApiUrl.services,
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        services = Services.fromJson(value.data);
        print("get service success");
        onSuccess!();
      } else {
        onError!();
      }
      emit(ServiceSuccessState());
    }).catchError((e) {
      emit(ServiceErrorState());
      print(e.toString());
    });
  }

  PopularServices? popularServices;

  void getPopularService({
    Function()? onError,
    Function()? onSuccess,
  }) async {
    emit(PopularLoadingState());
    DioHelper.getData(
      url: ApiUrl.popular,
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        popularServices = PopularServices.fromJson(value.data);
        print("get popular service success");
        onSuccess!();
      } else {
        onError!();
      }
      emit(PopularSuccessState());
    }).catchError((e) {
      emit(PopularErrorState());
      print(e.toString());
    });
  }

  CountryModel? countryModel;
   int pagenumber=1;
  void getCountry({
    Function()? onError,
    Function()? onSuccess,
   required int index,
  }) async {
    emit(CountryLoadingState());
    DioHelper.getData(
      url: ApiUrl.country,
      query: {
        "page":index
      },
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        countryModel = CountryModel.fromJson(value.data);
        print("get country success");
        onSuccess!();
      } else {
        onError!();
      }
      emit(CountrySuccessState());
    }).catchError((e) {
      emit(CountryErrorState());
      print(e.toString());
    });
  }
}
