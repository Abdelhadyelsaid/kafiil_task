import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_hiring_app/Controller/API_Controller/Home/home_cubit.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rate = 4.5;
    int number = 20;
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: .03.sh),
            child: SizedBox(
              height: .29.sh,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            color: Colors.white,
                            width: .45.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/product.svg',
                                          height: .15.sh,
                                          width: .45.sw,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          left: .02.sw,
                                          bottom: .02.sw,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xff1DBF73),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 5),
                                              child: Text(
                                                '\$100',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: .02.sw, vertical: 10.h),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Logo Design -Graphic Design Graphic Design",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SvgPicture.asset('assets/icons/star.svg'),
                                      Text(
                                        ' ($rate)   ',
                                        style: const TextStyle(
                                          color: Colors.yellow,
                                        ),
                                      ),
                                      const Text('|  ',
                                          style: TextStyle(color: Colors.grey)),
                                      SvgPicture.asset('assets/icons/icon.svg'),
                                      Text(
                                        ' $number',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                  itemCount: 10),
            ),
          );
        },
      ),
    );
  }
}
