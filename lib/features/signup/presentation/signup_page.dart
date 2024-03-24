import 'dart:developer';
import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/login/presentation/login_page.dart';
import 'package:opx_certification/features/signup/bloc/signup_bloc.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';
import 'package:opx_certification/utills/widgets/common_textfield.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';
import 'package:opx_certification/utills/widgets/footer.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  SignupBloc signupBloc = SignupBloc();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _sirenController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _countryCode = '+33';
  bool passwordStatus = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      bloc: signupBloc,
      buildWhen: (previous, current) => current is! SignupActionState,
      listenWhen: (previous, current) => current is SignupActionState,
      listener: (context, state) {
        log(state.toString());
        // TODO: implement listener
        if (state is SignupBackButtonNavigateActionState) {
          Navigator.pop(context);
        }

        if (state is SignupCountryCodeChangedState) {
          _countryCode = state.code;
        }
        if (state is SignupErrorState || state is SignupFailedState) {
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

        if (state is SignupSuccessedState) {
          context.loaderOverlay.hide();
          var snackBar = SnackBar(
            content: Text(
              'Account successfully created.',
              style: TextStyle(
                  fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.scaffoldBgColor),
            ),
            backgroundColor: AppColors.done,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 150, left: 10, right: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return LoginPage();
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

        if (state is SignupLoadingState) {
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
                          'Creating Your Account...',
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

        if (state is SignupLoginButtonNavigateActionState) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return LoginPage();
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

        // if (state is SignupPasswordButtonTappedState) {
        //   passwordStatus = state.newStauts;
        // }
      },
      builder: (context, state) {
        log(state.toString());

        if (state is SignupPasswordButtonTrueState) {
          passwordStatus = state.newStatus;
          log(state.newStatus.toString());
        }

        return Scaffold(
          backgroundColor: AppColors.scaffoldBgColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppBar().preferredSize.height,
                  ),
                  CommonBackButton(
                    onPressed: () {
                      signupBloc.add(SignupBacktButtonClickedEvent());
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Create Account',
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
                      text: 'Already have an account?',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.subHeadingFontColor),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                signupBloc.add(SignupLoginButtonClickedEvent());
                              },
                            text: ' Log in',
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
                          controller: _nameController,
                          hintText: 'Name',
                          fillColor: AppColors.textFieldBgColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
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
                        Row(
                          children: [
                            Container(
                              height: 48.5,
                              decoration: BoxDecoration(
                                  color: AppColors.textFieldBgColor, borderRadius: BorderRadius.circular(4)),
                              child: CountryCodePicker(
                                padding: const EdgeInsets.all(0),
                                hideSearch: false,
                                onChanged: (code) {
                                  signupBloc.add(SignupChnageCountryCodeEvent(code: code.dialCode!));
                                },
                                initialSelection: 'FR',
                                showCountryOnly: false,
                                textStyle: TextStyle(
                                    color: AppColors.subHeadingFontColor, fontSize: 14, fontWeight: FontWeight.w400),
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                                flagDecoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: CommonTextField(
                                controller: _phoneController,
                                hintText: 'Phone number',
                                fillColor: AppColors.textFieldBgColor,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone is empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          controller: _sirenController,
                          hintText: 'SIREN',
                          fillColor: AppColors.textFieldBgColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'SIREN is empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          controller: _companyController,
                          hintText: 'Company name',
                          fillColor: AppColors.textFieldBgColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Company name is empty';
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
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 8) {
                              return 'Your password must include at least 8 characters.';
                            }
                            return null;
                          },
                          suffixIcon: passwordStatus ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          onSuffixIconTap: () {
                            signupBloc.add(SignupChangePasswordStatusevent(passwordStatus));
                          },
                        ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // Text(
                        //   'Your password must include at least 8 characters.',
                        //   style: TextStyle(
                        //       color: AppColors.subHeadingFontColor,
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w400,
                        //       fontFamily: 'inter'),
                        // )
                      ],
                    ),
                  ),
                  CommonElevatedButton(
                    text: 'Create an account',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO submit
                        var phoneNumber = _countryCode + _phoneController.text;
                        signupBloc.add(SignupCreateAccountButtonClickedEvent(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: phoneNumber,
                            siren: _sirenController.text,
                            company: _companyController.text));
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
