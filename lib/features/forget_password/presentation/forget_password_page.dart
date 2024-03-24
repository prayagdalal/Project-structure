import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/check_email/presentation/check_email_page.dart';
import 'package:opx_certification/features/forget_password/bloc/forgetpassword_bloc.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';
import 'package:opx_certification/utills/widgets/common_textfield.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';
import 'package:opx_certification/utills/widgets/footer.dart';

ForgetpasswordBloc forgetpasswordBloc = ForgetpasswordBloc();

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetpasswordBloc, ForgetpasswordState>(
      bloc: forgetpasswordBloc,
      buildWhen: (previous, current) => current is! ForgetpasswordActionState,
      listenWhen: (previous, current) => current is ForgetpasswordActionState,
      listener: (context, state) {
        if (state is ForgetSendButtonState) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return CheckEmailPage(
                  email: 'prayagdalal1111@gmail.com',
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
          );
        }
        if (state is ForgetBackButtonNavigationState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBgColor,
          body: Padding(
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
                    forgetpasswordBloc.add(ForgetBackButtonClickedEvent());
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Forgot password',
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
                    text: 'We’ll send you a link to the email address you signed up with.',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.subHeadingFontColor),
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
                      ),
                    ],
                  ),
                ),
                CommonElevatedButton(
                  text: 'Send',
                  onPressed: () {
                    forgetpasswordBloc.add(ForgetSendButtonClickedEvent());
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
        );
      },
    );
  }
}
