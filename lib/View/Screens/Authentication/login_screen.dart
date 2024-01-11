import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_hiring_app/Const/constants.dart';
import 'package:kafiil_hiring_app/Controller/API_Controller/Authentication/authentication_cubit.dart';
import 'package:kafiil_hiring_app/Controller/App_Controller/app_controller_cubit.dart';
import 'package:kafiil_hiring_app/View/Screens/layout_screen.dart';
import 'package:kafiil_hiring_app/View/Screens/Authentication/register_screen.dart';
import 'package:kafiil_hiring_app/View/Widgets/default_button.dart';
import 'package:kafiil_hiring_app/View/Widgets/default_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 40.sp,
          ),
        ),
        title: const Text(
          "Account Login",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AppControllerCubit()),
            BlocProvider(create: (context) => AuthenticationCubit())
          ],
          child: BlocConsumer<AppControllerCubit, AppControllerState>(
            listener: (context, state) {},
            builder: (context, state) {
              var appCubit = AppControllerCubit.get(context);
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SvgPicture.asset('assets/images/login.svg'),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                            padding: EdgeInsets.symmetric(horizontal: .06.sw),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatefulBuilder(
                                  builder: (context, setState) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        appCubit.rememberMe =
                                            !appCubit.rememberMe;
                                      });
                                    },
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Checkbox(
                                                  value: appCubit.rememberMe,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      appCubit.rememberMe =
                                                          !appCubit.rememberMe;
                                                    });
                                                  })),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('Remember me')
                                        ]),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Colors.grey),
                                    ))
                              ],
                            ),
                          ),
                          BlocConsumer<AuthenticationCubit,
                              AuthenticationState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              AuthenticationCubit cubit =
                                  AuthenticationCubit.get(context);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: state is LoginLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: Color(0xFF1DBF73),
                                      ))
                                    : DefaultButton(
                                        function: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            cubit.login(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                onSuccess: () {
                                                  onSuccess(
                                                      context: context,
                                                      text:
                                                          "Log in Successfully !");
                                                  navigateAndFinish(context,
                                                      const LayoutScreen());
                                                },
                                                onError: () {
                                                  onError(context: context);
                                                });
                                          }
                                        },
                                        text: 'Login'),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don\'t have an account ?",
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                text: 'Register',
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
