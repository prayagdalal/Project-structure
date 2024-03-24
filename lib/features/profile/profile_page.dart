import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opx_certification/core/shared_pref.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/onboarding/presentation/onboarding_page.dart';
import 'package:opx_certification/features/profile/bloc/profile_bloc.dart';
import 'package:opx_certification/utills/modal_bottom_sheet/common_modal_sheet.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';
import 'package:opx_certification/utills/widgets/common_textfield.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sirenController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _localizationStatus = true;

  var email = SharedPref.getEmail();

  ProfileBloc profileBloc = ProfileBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ProfileSwitchState) {
          _localizationStatus = state.newSwitchStatus;
        }
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
                Row(
                  children: [
                    // CommonBackButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await SharedPref.clear();
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return OnboardingPage();
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
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.textFieldBgColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.logout_outlined,
                          size: 20,
                          color: AppColors.subHeadingFontColor,
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Your profile',
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
                    text: 'Manage your OPX profile settings.',
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
                InkWell(
                  onTap: () {
                    showCommonBottomSheet(
                        context: context,
                        sheetTitle: 'Company name',
                        controller: _companyController,
                        hintText: 'Company name',
                        buttonText: 'Update',
                        onPressed: () {});
                  },
                  child: Row(
                    children: [
                      Text(
                        'Company name',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.subHeadingFontColor),
                      ),
                      const Spacer(),
                      Text(
                        'Invision',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.headingFontColor),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.secondaryColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: AppColors.subHeadingFontColor,
                    thickness: 0.1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCommonBottomSheet(
                        context: context,
                        sheetTitle: 'SIREN',
                        controller: _sirenController,
                        hintText: 'SIREN',
                        buttonText: 'Update',
                        onPressed: () {});
                  },
                  child: Row(
                    children: [
                      Text(
                        'SIREN',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.subHeadingFontColor),
                      ),
                      const Spacer(),
                      Text(
                        '454154158',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.headingFontColor),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.secondaryColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: AppColors.subHeadingFontColor,
                    thickness: 0.1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCommonBottomSheet(
                        context: context,
                        sheetTitle: 'Email',
                        controller: _emailController,
                        hintText: 'Email',
                        buttonText: 'Update',
                        onPressed: () {});
                  },
                  child: Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.subHeadingFontColor),
                      ),
                      const Spacer(),
                      Text(
                        email.toString(),
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.headingFontColor),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.secondaryColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: AppColors.subHeadingFontColor,
                    thickness: 0.1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCommonBottomSheet(
                        context: context,
                        sheetTitle: 'Phone number',
                        controller: _phoneController,
                        hintText: 'Phone number',
                        buttonText: 'Update',
                        onPressed: () {});
                  },
                  child: Row(
                    children: [
                      Text(
                        'Phone number',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.subHeadingFontColor),
                      ),
                      const Spacer(),
                      Text(
                        '+33 700555002',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.headingFontColor),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.secondaryColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: AppColors.subHeadingFontColor,
                    thickness: 0.1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCommonBottomSheet(
                        context: context,
                        sheetTitle: 'Password',
                        controller: _passwordController,
                        hintText: 'Password',
                        buttonText: 'Update',
                        onPressed: () {});
                  },
                  child: Row(
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.subHeadingFontColor),
                      ),
                      const Spacer(),
                      Text(
                        '***********',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.headingFontColor),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.secondaryColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Text(
                  'Extras',
                  style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.headingFontColor),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/earth.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Localization',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.subHeadingFontColor),
                    ),
                    const Spacer(),
                    Switch(
                      value: _localizationStatus,
                      onChanged: (status) {
                        profileBloc.add(ProfileSwitchClickedEvent(status));
                      },
                      trackColor: MaterialStatePropertyAll(AppColors.secondaryColor),
                      inactiveThumbColor: Colors.white,
                      trackOutlineColor: MaterialStateProperty.all(AppColors.scaffoldBgColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
