import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double elevation;
  final double paddingVertical;
  final double paddingHorizontal;
  final bool? hasPrefixIcon;

  const CommonElevatedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.borderRadius = 8.0,
      this.elevation = 2.0,
      this.paddingVertical = 12.0,
      this.paddingHorizontal = 16.0,
      this.hasPrefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasPrefixIcon == true) ...[
              const Icon(
                Icons.add_circle_outline_rounded,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(
                width: 6,
              ),
            ],
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontFamily: 'Satoshi', fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}



// shadow on elevated button
// add margin on droptown is not proper
// Main controller blank text -> mandatory
// open camera
// GPS permission on Localization switch
