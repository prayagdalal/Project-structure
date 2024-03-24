import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:opx_certification/core/shared_pref.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/forget_password/presentation/forget_password_page.dart';
import 'package:opx_certification/features/home/presentation/home_page.dart';
import 'package:opx_certification/features/login/bloc/login_bloc.dart';
import 'package:opx_certification/features/signup/presentation/signup_page.dart';
import 'package:opx_certification/utills/bottom_app_bar/bottom_app_bar.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';
import 'package:opx_certification/utills/widgets/common_textfield.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';
import 'package:opx_certification/utills/widgets/footer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  LoginBloc loginBloc = LoginBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordStatus = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      buildWhen: (previous, current) => current is! LoginActionState,
      listenWhen: (previous, current) => current is LoginActionState,
      listener: (context, state) {
        if (state is LoginBackButtonNavigateActionState) {
          Navigator.pop(context);
        }

        if (state is LoginFailedState) {
          context.loaderOverlay.hide();
          var snackBar = SnackBar(
            content: Text(
              'Something went wrong!',
              style: TextStyle(
                  fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.scaffoldBgColor),
            ),
            backgroundColor: AppColors.delete,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 150, left: 10, right: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is LoginLoadingState) {
          context.loaderOverlay.show(
            widgetBuilder: (progress) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.5,
                  sigmaY: 4.5,
                ),
                child: Center(
                  child: Container(
                    width: 230,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: AppColors.scaffoldBgColor,
                              strokeWidth: 2,
                            )),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Logging into Your Account...',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.scaffoldBgColor, fontFamily: 'inter'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state is LoginSuccessedState) {
          context.loaderOverlay.hide();
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return BottomNavAppBar();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
        if (state is LoginSignupButtonNavigateActionState) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return SignupPage();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }

        if (state is LoginForgetPasswordNavigateActionState) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return ForgetPasswordPage();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginPasswordButtonTrueState) {
          passwordStatus = state.newStatus;
        }
        return Scaffold(
          backgroundColor: AppColors.scaffoldBgColor,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppBar().preferredSize.height,
                  ),
                  CommonBackButton(
                    onPressed: () {
                      loginBloc.add(LoginpBacktButtonClickedEvent());
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Login to account',
                    style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: AppColors.headingFontColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don’t have an account?',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.subHeadingFontColor),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                loginBloc.add(LoginSignupButtonClickedEvent());
                              },
                            text: ' Sign up',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.secondaryColor)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      children: [
                        CommonTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          fillColor: AppColors.textFieldBgColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          fillColor: AppColors.textFieldBgColor,
                          obscureText: passwordStatus ? false : true,
                          suffixIcon: passwordStatus ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          onSuffixIconTap: () {
                            loginBloc.add(LoginChangePasswordStatusevent(passwordStatus));
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            loginBloc.add(LoginFogetPasswordButtonClickedEvent());
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'inter'),
                          ),
                        )
                      ],
                    ),
                  ),
                  CommonElevatedButton(
                    text: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginBloc.add(LoginAccountButtonClickedEvent(
                            email: _emailController.text, password: _passwordController.text));
                      }
                    },
                    backgroundColor: AppColors.secondaryColor,
                    elevation: 0.1,
                    borderRadius: 4,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Footer()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
