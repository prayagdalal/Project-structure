import 'package:flutter/material.dart';
import 'package:opx_certification/design/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'By continuing, you accept our',
            style: TextStyle(
                fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.subHeadingFontColor),
          ),
        ),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: AppColors.secondaryColor)),
                TextSpan(
                    text: ' you read our',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.subHeadingFontColor)),
                TextSpan(
                    text: ' Privacy Policy.',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: AppColors.secondaryColor)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 48,
        )
      ],
    );
  }
}
