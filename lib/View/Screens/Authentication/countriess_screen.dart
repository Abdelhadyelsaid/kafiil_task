import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_hiring_app/Controller/API_Controller/Home/home_cubit.dart';
import 'package:number_paginator/number_paginator.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getCountry(index: 1),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          int number = 1;
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                "Countries",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: .05.sw, vertical: .01.sh),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            blurRadius: 30,
                            offset: const Offset(0, 0), // Shadow position
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: .05.sw, vertical: .02.sh),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: .05.sw, vertical: .015.sh),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Country',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'Capital',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                              height: .47.sh,
                              child: (state is CountryLoadingState ||
                                      cubit.countryModel == null
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Color(0xFF1DBF73),
                                    ))
                                  : ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: .07.sw),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    cubit.countryModel!
                                                        .data[index].name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: .2.sw,),
                                                Expanded(
                                                  child: Text(
                                                      cubit.countryModel!
                                                          .data[index].capital,
                                                      overflow:
                                                          TextOverflow.ellipsis),
                                                )
                                              ],
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                            thickness: 2,
                                            color: Colors.grey.shade100,
                                          ),
                                      itemCount: cubit
                                          .countryModel!.pagination.perPage))),
                        ],
                      ),
                    ),
                  ),
                  cubit.countryModel == null
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: .05.sw),
                          child: StatefulBuilder(
                            builder: (context, setState) => NumberPaginator(
                              numberPages:
                                  cubit.countryModel!.pagination.totalPages,
                              onPageChange: (int index) {
                                setState(() {
                                  number = index;
                                  cubit.pagenumber = index;
                                  cubit.getCountry(index: index);
                                });
                              },
                              config: NumberPaginatorUIConfig(
                                height: 45,
                                buttonShape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                buttonSelectedForegroundColor: Colors.white,
                                buttonUnselectedForegroundColor: Colors.black,
                                buttonUnselectedBackgroundColor:
                                    Colors.grey.shade100,
                                buttonSelectedBackgroundColor:
                                    const Color(0xFF1DBF73),
                              ),
                              showPrevButton: true,
                              showNextButton: true,
                              nextButtonContent: SvgPicture.asset(
                                'assets/icons/Next.svg',
                              ),
                              prevButtonContent: SvgPicture.asset(
                                'assets/icons/Prev.svg',
                              ),
                              // custom prev/next buttons using builder (ignored if showPrevButton/showNextButton is false)
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
