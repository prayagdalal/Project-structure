import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_bloc.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_state.dart';
import 'package:opx_certification/features/create_certificate/widgets/dilaog_box_widget.dart';

class AddPicturesWidget extends StatelessWidget {
  bool _localizationStatus = true;
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _selectedPictures = [];
  AddPicturesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CertificateBloc, CertificateState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        log('current state is:--$state');
        if (state is CertificateSwitchState) {
          _localizationStatus = state.newSwitchStatus;
        }
        if (state is ImageAddedOrRemovedInListState) {
          log('${state.status}--');
          _selectedPictures = context.read<CertificateBloc>().selectedPicturesList;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Add the pictures of thermostat in each room.',
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
            // Expanded(
            //   child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //     itemCount: _selectedPictures.length,
            //     itemBuilder: (context, index) {
            //       final key = _selectedPictures[index]['room_picture'];
            //       return ListTile(
            //         dense: true,
            //         contentPadding: EdgeInsets.zero,
            //         title: Text('$key'),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: context.read<CertificateBloc>().rooms + 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await _picker
                            .pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear)
                            .then((image) {
                          if (image != null && image.path.isNotEmpty) {
                            context.read<CertificateBloc>().add(CertificateAddImagesInListEvent(index + 1, image));
                          } else {
                            print('Failed to capture or retrieve image from the camera.');
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          decoration:
                              BoxDecoration(color: AppColors.textFieldBgColor, borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              _selectedPictures.where((element) => element['room_id'] == index + 1).isEmpty
                                  ? const Icon(Icons.add_circle_outline_rounded)
                                  : SvgPicture.asset('assets/images/Done.svg'),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                index == context.read<CertificateBloc>().rooms
                                    ? 'Main controller'
                                    : 'Thermostatic head',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.subHeadingFontColor),
                              ),
                              if (index != context.read<CertificateBloc>().rooms) ...[
                                const Spacer(),
                                Text(
                                  'Room ${index + 1}',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.subHeadingFontColor),
                                ),
                                if (_selectedPictures
                                    .where((element) => element['room_id'] == index + 1)
                                    .isNotEmpty) ...[
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var selectedPicture = _selectedPictures.firstWhere(
                                        (element) => element['room_id'] == index + 1,
                                      );
                                      if (selectedPicture.isNotEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return BlurryDialog(
                                                'Room ${index + 1} Picture', selectedPicture['room_picture'].path);
                                          },
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColors.subHeadingFontColor,
                                    ),
                                  )
                                ],
                                //  if (index == context.read<CertificateBloc>().rooms &&
                              ],
                              if (index == context.read<CertificateBloc>().rooms &&
                                  _selectedPictures.where((element) => element['room_id'] == index + 1).isNotEmpty) ...[
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    var selectedPicture = _selectedPictures.firstWhere(
                                      (element) => element['room_id'] == index + 1,
                                    );
                                    if (selectedPicture.isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BlurryDialog(
                                              'Main controller Picture', selectedPicture['room_picture'].path);
                                        },
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: AppColors.subHeadingFontColor,
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 24,
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
                    context.read<CertificateBloc>().add(CertificateSwitchClickedEvent(status));
                  },
                  trackColor: MaterialStatePropertyAll(AppColors.secondaryColor),
                  inactiveThumbColor: Colors.white,
                  trackOutlineColor: MaterialStateProperty.all(AppColors.scaffoldBgColor),
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
            RichText(
              text: TextSpan(
                text: 'We use localization for certification purposes.',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.subHeadingFontColor),
              ),
            ),
          ],
        );
      },
    );
  }

  _pickImageWithIndex(int index, context) async {
    await _picker.pickImage(source: ImageSource.camera).then((image) {
      if (image != null && (image.path.isNotEmpty || image.path != '')) {
        context.read<CertificateBloc>().add(CertificateAddImagesInListEvent(index + 1, image));
      }
      return null;
    });
  }
}
