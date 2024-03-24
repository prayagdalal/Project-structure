import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/create_certificate/models/certificate_model.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';

class CertificateDetailPage extends StatelessWidget {
  Data certificateDetails;
  CertificateDetailPage({
    required this.certificateDetails,
    super.key,
  });

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
            CommonBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Certificate #${certificateDetails.id}',
              style: TextStyle(
                  fontFamily: 'Satoshi', fontWeight: FontWeight.w700, fontSize: 30, color: AppColors.headingFontColor),
            ),
            const SizedBox(
              height: 12,
            ),
            RichText(
              text: TextSpan(
                text: 'View the details of your certificate.',
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
            Row(
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.parse(certificateDetails.createdAt!)),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.headingFontColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: AppColors.subHeadingFontColor,
                thickness: 0.1,
              ),
            ),
            Row(
              children: [
                Text(
                  certificateDetails.operationId.toString(),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Text(
                  'Heating',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.headingFontColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: AppColors.subHeadingFontColor,
                thickness: 0.1,
              ),
            ),
            Row(
              children: [
                Text(
                  'Housing type',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Text(
                  certificateDetails.housingType.toString(),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.headingFontColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: AppColors.subHeadingFontColor,
                thickness: 0.1,
              ),
            ),
            Row(
              children: [
                Text(
                  'Number of rooms',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Text(
                  certificateDetails.noRooms.toString(),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.headingFontColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: AppColors.subHeadingFontColor,
                thickness: 0.1,
              ),
            ),
            Row(
              children: [
                Text(
                  'Full name',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Text(
                  certificateDetails.fullName.toString(),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.headingFontColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: AppColors.subHeadingFontColor,
                thickness: 0.1,
              ),
            ),
            Row(
              children: [
                Text(
                  'Address',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Text(
                  certificateDetails.address.toString(),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.headingFontColor),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              'Certificate',
              style: TextStyle(
                  fontFamily: 'Satoshi', fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.headingFontColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SvgPicture.asset('assets/images/view.svg'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'View certificate',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.secondaryColor,
                  size: 16,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: AppColors.subHeadingFontColor,
                thickness: 0.1,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset('assets/images/share.svg'),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Share certificate',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.subHeadingFontColor),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.secondaryColor,
                  size: 16,
                )
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: Text('Delete certificate',
                      style: TextStyle(
                          fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.delete))),
            )
          ],
        ),
      ),
    );
  }
}
