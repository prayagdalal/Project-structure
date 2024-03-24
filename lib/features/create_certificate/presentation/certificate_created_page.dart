import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_bloc.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_state.dart';
import 'package:opx_certification/features/home/presentation/home_page.dart';
import 'package:opx_certification/utills/bottom_app_bar/bottom_app_bar.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';

class CertificateCreatedPage extends StatelessWidget {
  const CertificateCreatedPage({super.key});

  final bool _animate = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CertificateBloc, CertificateState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBgColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                          child: SizedBox(
                              height: 350,
                              child: SvgPicture.asset(
                                'assets/images/success.svg',
                                width: MediaQuery.of(context).size.width,
                              ))),
                      Positioned(
                        top: 50,
                        bottom: 50,
                        left: 50,
                        right: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: AvatarGlow(
                                startDelay: const Duration(milliseconds: 1000),
                                glowColor: AppColors.done,
                                glowShape: BoxShape.circle,
                                glowCount: 2,
                                animate: _animate,
                                curve: Curves.fastOutSlowIn,
                                child: Material(
                                  // Replace this child with your own
                                  elevation: 0,
                                  shape: const CircleBorder(),
                                  child: CircleAvatar(
                                      backgroundColor: AppColors.done,
                                      radius: 30.0,
                                      child: const Icon(
                                        Icons.done_rounded,
                                        color: Colors.white,
                                        size: 45,
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Text(
                                'Certificate created successfully!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                    color: AppColors.headingFontColor),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Your certificate has been sent to',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.subHeadingFontColor),
                            ),
                            Text('prayagdalal1111@gmail.com',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.headingFontColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CommonElevatedButton(
                  text: 'I’m done for now',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return BottomNavAppBar(
                              reload: true,
                            );
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
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
                        (Route<dynamic> route) => false);
                  },
                  backgroundColor: AppColors.secondaryColor,
                  elevation: 0.1,
                  borderRadius: 4,
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        // context.read<CertificateBloc>().add(ResetCertificateEvent());
                        // Navigator.pop(context);
                      },
                      child: Text('Create another certficate',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.secondaryColor))),
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
