import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_bloc.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_state.dart';
import 'package:opx_certification/features/create_certificate/presentation/certificate_created_page.dart';
import 'package:opx_certification/features/create_certificate/widgets/add_pictures_widget.dart';
import 'package:opx_certification/features/create_certificate/widgets/select_template_widget.dart';
import 'package:opx_certification/features/create_certificate/widgets/selected_template_metadata_widget.dart';
import 'package:opx_certification/utills/widgets/common_back_button.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';

class CreateCertificatePage extends StatelessWidget {
  CreateCertificatePage({super.key});

  PageController controller = PageController();

  int _currentStep = 0;
  final List<Widget> certifciateCreationSteps = <Widget>[
    SelectTemplateWidget(),
    SelectedTemplateMetaDataWidget(),
    AddPicturesWidget()
  ];

  @override
  Widget build(BuildContext context) {
    context.read<CertificateBloc>().add(ResetCertificateEvent());

    return WillPopScope(
      onWillPop: () async {
        log('Will pop scope---');
        context.read<CertificateBloc>().add(ResetCertificateEvent());
        return true;
      },
      child: BlocListener<CertificateBloc, CertificateState>(
          listener: (context, state) {
            // log(state.toString());
            if (state is CertificateInitial) {
              _currentStep = 0;
            }
            if (state is CertificateStepChangedState) {
              _currentStep = state.newStep;
              if (controller.hasClients) {
                controller.jumpToPage(state.newStep);
              }
            }
            if (state is CertificateStepChangedOnBackButtonState) {
              _currentStep = state.newStepOnBack;
              log(state.newStepOnBack.toString());
              if (controller.hasClients) {
                controller.previousPage(duration: const Duration(microseconds: 3000), curve: Curves.easeInBack);
              }
            }
            if (state is CertificateCreatingState) {
              log('in---');
              context.loaderOverlay.show(
                widgetBuilder: (progress) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.5,
                      sigmaY: 4.5,
                    ),
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: AppColors.scaffoldBgColor,
                                  strokeWidth: 2,
                                )),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Creating certificate...',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.scaffoldBgColor, fontFamily: 'inter'),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is CertificateCreatedSuccessState) {
              context.loaderOverlay.hide();
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const CertificateCreatedPage();
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
              );
            }
          },
          child: Scaffold(
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
                          CommonBackButton(
                            onPressed: () {
                              if (_currentStep == 2) {
                                context.read<CertificateBloc>().add(ChangeStepOnBackButtomClickEvent(2));
                              }
                              if (_currentStep == 1) {
                                context.read<CertificateBloc>().add(ChangeStepOnBackButtomClickEvent(1));
                              }
                              if (_currentStep == 0) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          const SizedBox(
                            width: 48,
                          ),
                          BlocBuilder<CertificateBloc, CertificateState>(
                            buildWhen: (previousState, currentState) {
                              if (currentState is CertificateStepChangedOnBackButtonState ||
                                  currentState is CertificateStepChangedState) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 220,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: AppColors.borderColor, borderRadius: BorderRadius.circular(12)),
                                  ),
                                  if (_currentStep == 0)
                                    Container(
                                      width: 220 / 3,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: AppColors.secondaryColor, borderRadius: BorderRadius.circular(12)),
                                    ),
                                  if (_currentStep == 1)
                                    Container(
                                      width: 220 / 1.5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: AppColors.secondaryColor, borderRadius: BorderRadius.circular(12)),
                                    ),
                                  if (_currentStep == 2)
                                    Container(
                                      width: 220,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: AppColors.secondaryColor, borderRadius: BorderRadius.circular(12)),
                                    ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Create certificate',
                        style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: AppColors.headingFontColor),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: controller,
                            physics: const NeverScrollableScrollPhysics(),
                            children: certifciateCreationSteps),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BlocBuilder<CertificateBloc, CertificateState>(
                        buildWhen: (previousState, currentState) {
                          if (currentState is CertificateStepChangedOnBackButtonState ||
                              currentState is CertificateStepChangedState ||
                              currentState is CertificateSelectNumberOfRoomState ||
                              currentState is ImageAddedOrRemovedInListState) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          return CommonElevatedButton(
                              elevation: 0.2,
                              textColor: (_currentStep == 0 ||
                                      _currentStep == 1 ||
                                      (_currentStep == 2 &&
                                          context.read<CertificateBloc>().selectedPicturesList.length ==
                                              context.read<CertificateBloc>().rooms + 1))
                                  ? AppColors.scaffoldBgColor
                                  : AppColors.subHeadingFontColor,
                              text: _currentStep == 0
                                  ? 'Validate'
                                  : _currentStep == 1
                                      ? 'Start certificate'
                                      : 'Create certificate',
                              backgroundColor: (_currentStep == 0 ||
                                      _currentStep == 1 ||
                                      (_currentStep == 2 &&
                                          context.read<CertificateBloc>().selectedPicturesList.length ==
                                              context.read<CertificateBloc>().rooms + 1))
                                  ? AppColors.secondaryColor
                                  : AppColors.textFieldBgColor,
                              onPressed: () {
                                if (_currentStep == 1 &&
                                    (context.read<CertificateBloc>().rooms == null ||
                                        context.read<CertificateBloc>().fullName == '' ||
                                        context.read<CertificateBloc>().address == '' ||
                                        context.read<CertificateBloc>().housingType == null ||
                                        context.read<CertificateBloc>().operation == null)) {
                                  var snackBar = SnackBar(
                                    content: Text(
                                      'Add the required details first',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: AppColors.scaffoldBgColor),
                                    ),
                                    backgroundColor: AppColors.delete,
                                    dismissDirection: DismissDirection.up,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).size.height - 150, left: 10, right: 10),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }

                                if (_currentStep == 0) {
                                  context.read<CertificateBloc>().add(ChangeCertifciateCreationStepEvent(_currentStep));
                                }

                                if (_currentStep == 1 &&
                                    (context.read<CertificateBloc>().rooms != null &&
                                        context.read<CertificateBloc>().fullName != '' &&
                                        context.read<CertificateBloc>().address != '' &&
                                        context.read<CertificateBloc>().housingType != null &&
                                        context.read<CertificateBloc>().operation != null)) {
                                  context.read<CertificateBloc>().add(ChangeCertifciateCreationStepEvent(_currentStep));
                                }

                                if (_currentStep == 2 &&
                                    context.read<CertificateBloc>().selectedPicturesList.length ==
                                        context.read<CertificateBloc>().rooms + 1) {
                                  context.read<CertificateBloc>().add(CreateCertificate());
                                }
                              });
                        },
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ]),
              ))),
    );
  }
}
