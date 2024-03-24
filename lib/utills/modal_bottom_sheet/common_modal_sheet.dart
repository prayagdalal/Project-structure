import 'package:flutter/material.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/utills/widgets/common_textfield.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';

void showCommonBottomSheet({
  required BuildContext context,
  required String sheetTitle,
  required TextEditingController controller,
  required String hintText,
  required String buttonText,
  required VoidCallback onPressed,
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.scaffoldBgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                sheetTitle,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.headingFontColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: AppColors.subHeadingFontColor,
                  thickness: 0.1,
                ),
              ),
              Expanded(
                child: CommonTextField(
                  controller: controller,
                  hintText: hintText,
                  fillColor: AppColors.textFieldBgColor,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              CommonElevatedButton(
                text: buttonText,
                onPressed: onPressed,
                backgroundColor: AppColors.secondaryColor,
                elevation: 0.1,
                borderRadius: 4,
              ),
            ],
          ),
        ),
      );
    },
  );
}
