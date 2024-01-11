import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_hiring_app/Const/Api_url.dart';
import 'package:kafiil_hiring_app/helper/dio_helper.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  void getProfile({
    Function()? onError,
    Function()? onSuccess,
  }) async {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: ApiUrl.profile,
    ).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
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
}
