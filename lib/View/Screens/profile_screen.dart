import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_hiring_app/Controller/API_Controller/Authentication/authentication_cubit.dart';
import 'package:kafiil_hiring_app/Controller/App_Controller/app_controller_cubit.dart';
import 'package:kafiil_hiring_app/View/Widgets/default_form_field.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var dateController = TextEditingController();
    var aboutController = TextEditingController();
    var salaryController = TextEditingController();
    return Scaffold(
    appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Who Am I",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AppControllerCubit()),
            BlocProvider(create: (context) => AuthenticationCubit()),
          ],
          child: BlocConsumer<AppControllerCubit, AppControllerState>(
            listener: (context, state) {},
            builder: (context, state) {
              var appCubit = AppControllerCubit.get(context);
              return Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BlocConsumer<AuthenticationCubit,
                              AuthenticationState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              var cubit = AuthenticationCubit.get(context);
                              return InkWell(
                                onTap: () async {
                                  await cubit.chooseImage();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: cubit.image != null
                                        ? Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: CircleBorder(),
                                      child: Image.file(
                                        cubit.image!,
                                        fit: BoxFit.contain,
                                        width: 120.w,
                                        height: 120.h,
                                      ),
                                    )
                                        : Stack(children: [
                                      Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: CircleBorder(),
                                          child: SvgPicture.asset(
                                            'assets/images/login.svg',
                                            fit: BoxFit.contain,
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: .05.sw),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                defaultFormField(
                                    width: .43.sw,
                                    title: 'First Name',
                                    controller: firstNameController,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter first name !';
                                      }
                                    },
                                    hint: ''),
                                defaultFormField(
                                    width: .43.sw,
                                    title: 'Last Name',
                                    controller: lastNameController,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter last name !';
                                      }
                                    },
                                    hint: ''),
                              ],
                            ),
                          ),
                          defaultFormField(
                              title: 'Email Address',
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Email !';
                                }
                              },
                              hint: ''),
                          defaultFormField(
                              isPassword: appCubit.showPassword,
                              title: 'Password',
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffixPressed: () {
                                appCubit.switchPasswordVisibility();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password !';
                                }
                              },
                              suffix: appCubit.showPassword
                                  ? SvgPicture.asset(
                                'assets/icons/hide_pass.svg',
                              )
                                  : SvgPicture.asset(
                                'assets/icons/show_pass.svg',
                                width: 18,
                                height: 18,
                              ),
                              hint: ''),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: .05.sw),
                            child: const Row(
                              children: [
                                Text(
                                  'User Type',
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
                                      title: const Text('Seller'),
                                      contentPadding: const EdgeInsets.all(0.0),
                                      value: 'Seller',
                                      groupValue: appCubit.userType,
                                      onChanged: (value) {
                                        setState(() {
                                          appCubit.userType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      contentPadding: const EdgeInsets.all(0.0),
                                      title: const Text('Buyer'),
                                      value: 'Buyer',
                                      groupValue: appCubit.userType,
                                      onChanged: (value) {
                                        setState(() {
                                          appCubit.userType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      contentPadding: const EdgeInsets.all(0.0),
                                      title: const Text('Both'),
                                      value: 'Both',
                                      groupValue: appCubit.userType,
                                      onChanged: (value) {
                                        setState(() {
                                          appCubit.userType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                          defaultFormField(
                              title: 'Salary',
                              controller: salaryController,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill this field !';
                                }
                              },
                              hint: ''),
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
                        ],
                      ),)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
