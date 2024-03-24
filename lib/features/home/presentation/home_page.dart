import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/certificate_detail/presentation/certificate_detail_page.dart';
import 'package:opx_certification/features/create_certificate/models/certificate_model.dart';
import 'package:opx_certification/features/create_certificate/presentation/create_certificate_page.dart';
import 'package:opx_certification/features/home/bloc/home_bloc.dart';
import 'package:opx_certification/utills/widgets/common_textfield.dart';
import 'package:opx_certification/utills/widgets/elevated_button_widget.dart';

class HomePage extends StatelessWidget {
  bool? reload = false;
  HomePage({super.key, this.reload});

  final TextEditingController _searchController = TextEditingController();

  List<Data> certificates = [];

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(LoadAllCertificatesEvent());
    // if (certificates.isEmpty) {
    //   context.read<HomeBloc>().add(LoadAllCertificatesEvent());
    // }

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            shrinkWrap: true,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              CommonTextField(
                controller: _searchController,
                hintText: 'Search for certificate',
                prefixIcon: Icons.search,
                isSearch: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              const SizedBox(
                height: 34,
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.scaffoldBgColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Summary',
                      style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: AppColors.headingFontColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.borderColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Total certificates',
                                    style: TextStyle(
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: AppColors.headingFontColor),
                                  ),
                                  BlocBuilder<HomeBloc, HomeState>(
                                    builder: (context, state) {
                                      return Text(
                                        certificates.length.toString(),
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                            color: AppColors.headingFontColor),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.borderColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Credits left',
                                    style: TextStyle(
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: AppColors.headingFontColor),
                                  ),
                                  Text(
                                    '14',
                                    style: TextStyle(
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        color: AppColors.headingFontColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
                          return Expanded(
                            child: Center(
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(color: AppColors.secondaryColor, strokeWidth: 2)),
                            ),
                          );
                        }
                        if (state is HomeLoaded) {
                          certificates = state.certificateModel.data!;
                          return certificates.isEmpty
                              ? ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/no data.svg',
                                      height: 170,
                                    ),
                                    Center(
                                      child: Text(
                                        'No certifications yet',
                                        style: TextStyle(
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: AppColors.headingFontColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Center(
                                      child: Text(
                                        'When you create one, you will see it here.',
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.subHeadingFontColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    CommonElevatedButton(
                                      text: 'Create new certificate',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) {
                                              return CreateCertificatePage();
                                            },
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              var begin = const Offset(1.0, 0.0);
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
                                      },
                                      backgroundColor: AppColors.secondaryColor,
                                      textColor: Colors.white,
                                      hasPrefixIcon: true,
                                    ),
                                  ],
                                )
                              : Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonElevatedButton(
                                        text: 'Create new certificate',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return CreateCertificatePage();
                                              },
                                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                var begin = const Offset(1.0, 0.0);
                                                var end = Offset.zero;
                                                var curve = Curves.ease;
                                                var tween =
                                                    Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                                var offsetAnimation = animation.drive(tween);
                                                return SlideTransition(
                                                  position: offsetAnimation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        backgroundColor: AppColors.secondaryColor,
                                        textColor: Colors.white,
                                        hasPrefixIcon: true,
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Text(
                                        'Recent certifications',
                                        style: TextStyle(
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: AppColors.headingFontColor),
                                      ),
                                      Expanded(
                                        child: ListView.separated(
                                            padding: EdgeInsets.zero,
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                color: AppColors.subHeadingFontColor,
                                                thickness: 0.1,
                                              );
                                            },
                                            itemCount: certificates.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    print('tapped');
                                                    Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context, animation, secondaryAnimation) {
                                                          return CertificateDetailPage(
                                                            certificateDetails: certificates[index],
                                                          );
                                                        },
                                                        transitionsBuilder:
                                                            (context, animation, secondaryAnimation, child) {
                                                          var begin = const Offset(1.0, 0.0);
                                                          var end = Offset.zero;
                                                          var curve = Curves.ease;

                                                          var tween = Tween(begin: begin, end: end)
                                                              .chain(CurveTween(curve: curve));

                                                          var offsetAnimation = animation.drive(tween);

                                                          return SlideTransition(
                                                            position: offsetAnimation,
                                                            child: child,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(4),
                                                        height: 28,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.textFieldBgColor,
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '#${certificates[index].id ?? ''}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily: 'inter',
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.subHeadingFontColor),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 45,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            certificates[index].address! ?? '',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily: 'inter',
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.headingFontColor),
                                                          ),
                                                          Text(
                                                            '${DateFormat('dd/MM/yyyy').format(DateTime.parse(certificates[index].createdAt!))}- ${certificates[index].fullName!}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily: 'inter',
                                                                fontWeight: FontWeight.w400,
                                                                color: AppColors.subHeadingFontColor),
                                                          )
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: AppColors.secondaryColor,
                                                        size: 16,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
