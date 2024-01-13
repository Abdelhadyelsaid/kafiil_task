import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_hiring_app/Controller/API_Controller/Home/home_cubit.dart';
import 'package:kafiil_hiring_app/View/Widgets/services.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Services",
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: .05.sw),
        child: BlocProvider(
          create: (context) => HomeCubit()
            ..getService()
            ..getPopularService(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              HomeCubit cubit = HomeCubit.get(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cubit.services == null || state is ServiceLoadingState
                      ? Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: .07.sh),
                        child: CircularProgressIndicator(color: Color(0xFF1DBF73)),
                      ))
                      : ServicesList(
                          services: cubit.services!.data,
                        ),
                  Text(
                    'Popular Services',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 25.sp),
                  ),
                  cubit.popularServices == null || state is PopularLoadingState
                      ? Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: .07.sh),
                        child: CircularProgressIndicator(color: Color(0xFF1DBF73)),
                      ))
                      : ServicesList(
                          services: cubit.popularServices!.data,
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
