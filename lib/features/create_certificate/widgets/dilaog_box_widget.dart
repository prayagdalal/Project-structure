import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:opx_certification/design/app_colors.dart';

class BlurryDialog extends StatelessWidget {
  String title;
  String imagePath;

  BlurryDialog(this.title, this.imagePath, {super.key});
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: TextStyle(
                fontFamily: 'Satoshi', fontWeight: FontWeight.w700, fontSize: 30, color: AppColors.headingFontColor),
          ),
          content: Image.file(File(imagePath)),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.secondaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
