import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/login/presentation/login_page.dart';
import 'package:opx_certification/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:opx_certification/features/signup/presentation/signup_page.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final OnboardingBloc onboardingBloc = OnboardingBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      bloc: onboardingBloc,
      listenWhen: (previous, current) => current is OnboardingActionState,
      buildWhen: (previous, current) => current is! OnboardingActionState,
      listener: (context, state) {
        if (state is OnboardingNavigateToSignupPageActionState) {
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
        if (state is OnboardingNavigateToLoginPageActionState) {
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
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBgColor,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        color: AppColors.secondaryColor,
                        alignment: Alignment.topCenter,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                            ),
                            SvgPicture.asset('assets/images/logo.svg'),
                            const SizedBox(
                              height: 70,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.2),
                                      blurRadius: 100,
                                      offset: const Offset(0, 3),
                                      spreadRadius: 1,
                                      // You can adjust these values to customize the glow effect
                                    ),
                                  ],
                                ),
                                child: Image.asset('assets/images/OPX.png')),
                          ],
                        )),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height / 1.8,
                child: Container(
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 3,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.scaffoldBgColor,
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Introducing the new standard for CEE',
                          style: TextStyle(
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: AppColors.headingFontColor),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          'OPX is the first SaaS platform for managing White Certificates, connecting all players in the energy renovation industry.',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.subHeadingFontColor),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CommonElevatedButton(
                          text: 'Create an account',
                          onPressed: () {
                            onboardingBloc.add(OnboardingCreateAccountButtonNavigateEvent());
                          },
                          backgroundColor: AppColors.secondaryColor,
                          elevation: 0.1,
                          borderRadius: 4,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CommonElevatedButton(
                          text: 'I already have an account',
                          onPressed: () {
                            onboardingBloc.add(OnboardingAlreadyHaveAccountButtonNavigateEvent());
                          },
                          backgroundColor: AppColors.textFieldBgColor,
                          elevation: 0.1,
                          borderRadius: 4,
                          textColor: AppColors.headingFontColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
