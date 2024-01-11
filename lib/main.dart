import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_hiring_app/Controller/App_Controller/app_controller_cubit.dart';
import 'package:kafiil_hiring_app/View/Screens/Authentication/CompleteDataScreen.dart';
import 'package:kafiil_hiring_app/View/Screens/Authentication/login_screen.dart';
import 'package:kafiil_hiring_app/View/Screens/profile_screen.dart';
import 'package:kafiil_hiring_app/helper/cache_helper.dart';
import 'package:kafiil_hiring_app/helper/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppControllerCubit(),
      child: BlocConsumer<AppControllerCubit, AppControllerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 760),
            builder: (_, child) =>
                MaterialApp(
                    title: 'Kafiil',
                    theme: ThemeData(
                      scaffoldBackgroundColor: Colors.white,
                      colorScheme: ColorScheme.fromSeed(
                          seedColor: const Color(0xFF1DBF73)),
                      useMaterial3: true,
                    ),
                    debugShowCheckedModeBanner: false,
                    home: const ProfileScreen()),
          );
        },
      ),
    );
  }
}
