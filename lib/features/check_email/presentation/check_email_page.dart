import 'package:flutter/material.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';
import 'package:opx_certification/utills/widgets/footer.dart';

class CheckEmailPage extends StatelessWidget {
  String email;

  CheckEmailPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
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
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.textFieldBgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.close),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Check your email',
              style: TextStyle(
                  fontFamily: 'Satoshi', fontWeight: FontWeight.w700, fontSize: 30, color: AppColors.headingFontColor),
            ),
            const SizedBox(
              height: 12,
            ),
            RichText(
              text: TextSpan(
                text: 'We’ sent an email to $email with the link to change your password.',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.subHeadingFontColor),
              ),
            ),
            // const SizedBox(
            //   height: 24,
            // ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: AppColors.subHeadingFontColor,
              thickness: 0.1,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Need help?',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.subHeadingFontColor)),
                        TextSpan(
                            text: ' Contact us',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.secondaryColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CommonElevatedButton(
              text: 'Check email',
              onPressed: () {},
              backgroundColor: AppColors.secondaryColor,
              elevation: 0.1,
              borderRadius: 4,
            ),
            const SizedBox(
              height: 12,
            ),
            CommonElevatedButton(
              text: 'Resend',
              onPressed: () {},
              backgroundColor: AppColors.textFieldBgColor,
              elevation: 0.1,
              borderRadius: 4,
              textColor: AppColors.headingFontColor,
            ),
            const SizedBox(
              height: 22,
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}
