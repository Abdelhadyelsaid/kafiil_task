import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_hiring_app/Controller/App_Controller/app_controller_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppControllerCubit, AppControllerState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppControllerCubit.get(context);
        return Scaffold(
            extendBody: true,
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: (index) {
                cubit.changeBottomScreen(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: cubit.currentIndex == 0
                      ? SvgPicture.asset(
                          'assets/icons/who_I.svg',
                          color: const Color(0xFF1DBF73),
                        )
                      : SvgPicture.asset('assets/icons/who_I.svg'),
                  label: 'Who Am I',
                ),
                BottomNavigationBarItem(
                  icon: cubit.currentIndex == 1
                      ? SvgPicture.asset(
                          'assets/icons/countries.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/countries.svg',
                          color: Colors.grey,
                        ),
                  label: 'Countries',
                ),
                BottomNavigationBarItem(
                  icon: cubit.currentIndex == 2
                      ? SvgPicture.asset(
                          'assets/icons/shopping.svg',
                          color: const Color(0xFF1DBF73),
                        )
                      : SvgPicture.asset('assets/icons/shopping.svg'),
                  label: 'Services',
                ),
              ],
            ));
      },
    );
  }
}
