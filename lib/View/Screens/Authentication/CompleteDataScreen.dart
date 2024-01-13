import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_hiring_app/Controller/API_Controller/Authentication/authentication_cubit.dart';
import 'package:kafiil_hiring_app/Controller/App_Controller/app_controller_cubit.dart';
import 'package:kafiil_hiring_app/View/Widgets/default_button.dart';
import 'package:kafiil_hiring_app/View/Widgets/default_form_field.dart';

class CompleteDataScreen extends StatelessWidget {
  const CompleteDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var aboutController = TextEditingController();
    var dateController = TextEditingController();
    var salaryController = TextEditingController();
    int salary = 100;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 40.sp,
          ),
        ),
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AppControllerCubit()),
            BlocProvider(create: (context) => AuthenticationCubit()),
          ],
          child: BlocConsumer<AppControllerCubit, AppControllerState>(
            listener: (context, state) {},
            builder: (context, state) {
              var appCubit = AppControllerCubit.get(context);
              var cubit = AuthenticationCubit.get(context);
              return Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          state is showErrorMessageState
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: .05.sw),
                                  child: SvgPicture.asset(
                                    'assets/images/error_message.svg',
                                    height: 40,
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: SvgPicture.asset(
                                "assets/images/complete_data.svg"),
                          ),
                          BlocConsumer<AuthenticationCubit,
                              AuthenticationState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return InkWell(
                                onTap: () async {
                                  await cubit.chooseImage();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: cubit.image != null
                                        ? Stack(children: [
                                            Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: CircleBorder(),
                                              child: Image.file(
                                                cubit.image!,
                                                fit: BoxFit.cover,
                                                width: 120.w,
                                                height: 120.h,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -4,
                                              right: -4,
                                              child: IconButton(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  onPressed: () {
                                                    cubit.chooseImage();
                                                  },
                                                  icon: SvgPicture.asset(
                                                    'assets/images/add_button.svg',
                                                    height: 37,
                                                    width: 37,
                                                  )),
                                            )
                                          ])
                                        : Stack(children: [
                                            Card(
                                                clipBehavior: Clip.antiAlias,
                                                shape: CircleBorder(),
                                                child: SvgPicture.asset(
                                                  'assets/images/user.svg',
                                                  fit: BoxFit.fill,
                                                  width: 120.w,
                                                  height: 120.h,
                                                )),
                                            Positioned(
                                              bottom: -4,
                                              right: -4,
                                              child: IconButton(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  onPressed: () {
                                                    cubit.chooseImage();
                                                  },
                                                  icon: SvgPicture.asset(
                                                    'assets/images/add_button.svg',
                                                    height: 37,
                                                    width: 37,
                                                  )),
                                            )
                                          ])),
                              );
                            },
                          ),
                          defaultFormField(
                              maxLines: 3,
                              title: 'About',
                              controller: aboutController,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill this field !';
                                }
                              },
                              hint: ''),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: .05.sw),
                            child: const Row(
                              children: [
                                Text(
                                  'Salary',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: .05.sw, vertical: .01.sh),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey.shade100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (salary > 100) {
                                            salary -= 100;
                                            salaryController.text =
                                                'SAR $salary';
                                          }
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                          'assets/icons/minus_button.svg'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: .07.sw),
                                      child: Text('SAR $salary'),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (salary < 1000) {
                                            salary += 100;
                                            salaryController.text =
                                                'SAR $salary';
                                          }
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                          'assets/icons/plus_button.svg'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => defaultFormField(
                                title: 'Birth Date',
                                controller: dateController,
                                suffix: SvgPicture.asset(
                                    'assets/icons/calendar.svg'),
                                suffixPressed: () async {
                                  final DateTime? dateTime =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2045));
                                  if (dateTime != null) {
                                    setState(() {
                                      var formattedDate =
                                          "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                      dateController.text =
                                          formattedDate.toString();
                                    });
                                  }
                                },
                                type: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill this field !';
                                  }
                                },
                                hint: ''),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: .05.sw),
                            child: const Row(
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: .05.sw),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      title: const Text('Male'),
                                      contentPadding: const EdgeInsets.all(0.0),
                                      value: 'Male',
                                      groupValue: appCubit.gender,
                                      onChanged: (value) {
                                        setState(() {
                                          appCubit.gender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      contentPadding: const EdgeInsets.all(0.0),
                                      title: const Text('Female'),
                                      value: 'Female',
                                      groupValue: appCubit.gender,
                                      onChanged: (value) {
                                        setState(() {
                                          appCubit.gender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: .05.sw),
                            child: const Row(
                              children: [
                                Text(
                                  'Skills',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: .05.sw),
                            child: const Row(
                              children: [
                                Text(
                                  'Favourite Social Media',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: .06.sw, vertical: .01.sh),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            appCubit.facebook =
                                                !appCubit.facebook;
                                          });
                                        },
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Checkbox(
                                                      value: appCubit.facebook,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          appCubit.facebook =
                                                              !appCubit
                                                                  .facebook;
                                                        });
                                                      })),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: SvgPicture.asset(
                                                    'assets/icons/facebook.svg'),
                                              ),
                                              Text(
                                                'Facebook',
                                                style:
                                                    TextStyle(fontSize: 16.sp),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: .06.sw, vertical: .01.sh),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            appCubit.twitter =
                                                !appCubit.twitter;
                                          });
                                        },
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Checkbox(
                                                      value: appCubit.twitter,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          appCubit.twitter =
                                                              !appCubit.twitter;
                                                        });
                                                      })),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: SvgPicture.asset(
                                                    'assets/icons/twitter.svg'),
                                              ),
                                              Text(
                                                'Twitter',
                                                style:
                                                    TextStyle(fontSize: 16.sp),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: .06.sw, vertical: .01.sh),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            appCubit.linkedIn =
                                                !appCubit.linkedIn;
                                          });
                                        },
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Checkbox(
                                                      value: appCubit.linkedIn,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          appCubit.linkedIn =
                                                              !appCubit
                                                                  .linkedIn;
                                                        });
                                                      })),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: SvgPicture.asset(
                                                  'assets/icons/LinkedIn_icon.svg',
                                                  height: 21,
                                                  width: 19,
                                                ),
                                              ),
                                              Text(
                                                'LinkedIn',
                                                style:
                                                    TextStyle(fontSize: 16.sp),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: .05.sw, vertical: 20),
                                child: DefaultButton(
                                  function: () {
                                    if (!_formKey.currentState!.validate()) {
                                      appCubit.switchErrorMessageVisibility();
                                    } else {
                                      appCubit.RemoveErrorMessage();
                                      // navigateTo(
                                      //     context, const CompleteDataScreen());
                                    }
                                  },
                                  text: 'Submit',
                                  width: .9.sw,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
