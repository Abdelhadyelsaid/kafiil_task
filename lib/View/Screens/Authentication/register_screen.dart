import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_hiring_app/Const/constants.dart';
import 'package:kafiil_hiring_app/Controller/App_Controller/app_controller_cubit.dart';
import 'package:kafiil_hiring_app/View/Screens/Authentication/CompleteDataScreen.dart';
import 'package:kafiil_hiring_app/View/Widgets/default_button.dart';
import 'package:kafiil_hiring_app/View/Widgets/default_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordConfirmController = TextEditingController();
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
                          child: SvgPicture.asset("assets/images/register.svg"),
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
                        defaultFormField(
                            isPassword: appCubit.showConfirmPassword,
                            title: 'Confirm Password',
                            controller: passwordConfirmController,
                            type: TextInputType.visiblePassword,
                            suffixPressed: () {
                              appCubit.switchConfirmPasswordVisibility();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Re-enter your password !';
                              } else if (passwordConfirmController.text !=
                                  passwordController.text) {
                                return 'Password mismatch';
                              }
                            },
                            suffix: appCubit.showConfirmPassword
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
                                    value: 2,
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
                                    value: 1,
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
                                    value: 3,
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
                                    navigateTo(
                                        context, const CompleteDataScreen());
                                  }
                                },
                                text: 'Next',
                                width: .43.sw,
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
    );
  }
}
