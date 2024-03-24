import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/credits/presentation/credit_page.dart';
import 'package:opx_certification/features/home/presentation/home_page.dart';
import 'package:opx_certification/features/profile/profile_page.dart';
import 'package:opx_certification/utills/bottom_app_bar/bloc/bottom_app_bar_bloc.dart';

class BottomNavAppBar extends StatelessWidget {
  bool? reload = false;
  BottomNavAppBar({super.key, this.reload});

  List<Widget> widgetList = [HomePage(), CreditPage(), ProfilePage()];

  BottomAppBarBloc bottomAppBarBloc = BottomAppBarBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomAppBarBloc, BottomAppBarState>(
      bloc: bottomAppBarBloc,
      builder: (context, state) {
        int myIndex = 0;

        if (state is BottomAppBarSelectedState) {
          myIndex = state.selectedIndex;
        }
        return Scaffold(
          body: widgetList[myIndex],
          bottomNavigationBar: SizedBox(
            height: Platform.isIOS ? 90 : 80,
            child: BottomNavigationBar(
                backgroundColor: AppColors.scaffoldBgColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedIconTheme: IconThemeData(color: AppColors.secondaryColor),
                selectedLabelStyle: TextStyle(
                    color: AppColors.secondaryColor, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'inter'),
                unselectedLabelStyle: TextStyle(
                    color: AppColors.subHeadingFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'inter'),
                selectedItemColor: AppColors.secondaryColor,
                elevation: 0,
                currentIndex: myIndex,
                onTap: (index) {
                  bottomAppBarBloc.add(BottomAppBarClickedEvent(index));
                },
                items: [
                  BottomNavigationBarItem(
                      icon: myIndex == 0
                          ? SvgPicture.asset(
                              'assets/images/home_filled.svg',
                              height: 16,
                            )
                          : SvgPicture.asset(
                              'assets/images/home.svg',
                              height: 16,
                            ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: myIndex == 1
                          ? SvgPicture.asset(
                              'assets/images/credit_filled.svg',
                              height: 16,
                            )
                          : SvgPicture.asset(
                              'assets/images/credit.svg',
                              height: 16,
                            ),
                      label: 'Credits'),
                  BottomNavigationBarItem(
                      icon: myIndex == 2
                          ? SvgPicture.asset(
                              'assets/images/profile_filled.svg',
                              height: 16,
                            )
                          : SvgPicture.asset(
                              'assets/images/profile.svg',
                              height: 16,
                            ),
                      label: 'Profile')
                ]),
          ),
        );
      },
    );
  }
}
