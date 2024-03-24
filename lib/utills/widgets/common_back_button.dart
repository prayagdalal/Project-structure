import 'package:flutter/material.dart';
import 'package:opx_certification/design/app_colors.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double size;

  const CommonBackButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: AppColors.textFieldBgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
