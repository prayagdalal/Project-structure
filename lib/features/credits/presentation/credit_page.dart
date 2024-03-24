import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/credits/bloc/credits_bloc.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';

class CreditPage extends StatelessWidget {
  CreditPage({super.key});

  CreditsBloc creditsBloc = CreditsBloc();

  int _selectedCredits = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditsBloc, CreditsState>(
      bloc: creditsBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is CreditsChangeState) {
          _selectedCredits = state.newCreditIndex;
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
                    Container(
                      height: 40,
                      width: 106,
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Credits: ',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.subHeadingFontColor),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '20',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.headingFontColor)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Purchase credits',
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
                    text: 'Select a package from the options listed below.',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.subHeadingFontColor),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: _selectedCredits == index
                                  ? AppColors.secondaryColor.withOpacity(0.1)
                                  : AppColors.scaffoldBgColor,
                              border: Border.all(
                                  color: _selectedCredits == index ? AppColors.secondaryColor : AppColors.borderColor,
                                  width: 1.8)),
                          child: InkWell(
                            onTap: () => creditsBloc.add(CreditChangeButtonPressedEvent(index)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                              child: Row(
                                children: [
                                  _selectedCredits == index
                                      ? Container(
                                          height: 18,
                                          width: 18,
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.secondaryColor.withOpacity(0.1), width: 1.8)),
                                          child: SvgPicture.asset(
                                            'assets/images/Radio_selected.svg',
                                          ),
                                        )
                                      : Container(
                                          height: 18,
                                          width: 18,
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: AppColors.borderColor, width: 1.8))),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '100 credits',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: AppColors.headingFontColor),
                                      ),
                                      Text(
                                        '20 €HT - 2 €HT each',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.secondaryColor),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                CommonElevatedButton(
                  text: 'Buy credits',
                  onPressed: () {},
                  backgroundColor: AppColors.secondaryColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
