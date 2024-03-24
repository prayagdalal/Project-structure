import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_bloc.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_state.dart';
import 'package:opx_certification/features/create_certificate/models/operations_model.dart';
import 'package:opx_certification/utills/widgets/common_textfield.dart';

class SelectedTemplateMetaDataWidget extends StatelessWidget {
  SelectedTemplateMetaDataWidget({super.key});

  var selectedOperation;

  var selectedHousingType;

  var selectedRoom;

  bool _operationLoader = true;
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Data> operations = [];

  @override
  Widget build(BuildContext context) {
    if (operations.isEmpty) {
      context.read<CertificateBloc>().add(LoadOperations());
    }

    return BlocConsumer<CertificateBloc, CertificateState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        log(state.toString());

        if (state is CertificateSelectOperationState) {
          selectedOperation = state.newSelectedOperation;
        }
        if (state is CertificateSelectHousingState) {
          selectedHousingType = state.newSelectedHousingType;
        }
        if (state is CertificateSelectNumberOfRoomState) {
          selectedRoom = state.selectedNumberOfRooms;
        }
        if (state is OperationLoadedSuccessState) {
          log(state.operationObject.data![0].label.toString());
          _operationLoader = false;
          operations = state.operationObject.data!;
        }
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Selected template',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.subHeadingFontColor),
                      ),
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        text: 'Template',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.headingFontColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: AppColors.textFieldBgColor, borderRadius: BorderRadius.circular(4)),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      dropdownColor: AppColors.scaffoldBgColor,
                      hint: const Text('Operation'),
                      elevation: 3,
                      borderRadius: BorderRadius.circular(12),
                      underline: const SizedBox(),
                      value: selectedOperation,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.subHeadingFontColor),
                      onChanged: (String? newValue) {
                        log('$newValue----selcted');
                        context.read<CertificateBloc>().add(SelectOperationEvent(newValue!));
                      },
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: operations.map<DropdownMenuItem<String>>((Data value) {
                        return DropdownMenuItem<String>(
                          enabled: _operationLoader ? false : true,
                          value: value.id.toString(),
                          child: Text(value.code!),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: AppColors.textFieldBgColor, borderRadius: BorderRadius.circular(4)),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      dropdownColor: AppColors.scaffoldBgColor,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(12),
                      underline: const SizedBox(),
                      value: selectedHousingType,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.subHeadingFontColor),
                      onChanged: (String? newValue) {
                        context.read<CertificateBloc>().add(SelectHousingTypeEvent(newValue!));
                      },
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hint: const Text('Housing type'),
                      items: <String>['Type 1', 'Type 2', 'Type 3'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: AppColors.textFieldBgColor, borderRadius: BorderRadius.circular(4)),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<int>(
                      dropdownColor: AppColors.scaffoldBgColor,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(12),
                      underline: const SizedBox(),
                      value: selectedRoom,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.subHeadingFontColor),
                      onChanged: (int? newValue) {
                        context.read<CertificateBloc>().add(SelectNumberOfRoomEvent(newValue!));
                      },
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hint: const Text('Number of rooms'),
                      items: <int>[1, 2, 3, 4, 5, 6, 7, 8].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                //Validation
                // context.read<CertificateBloc>().rooms == null
                //     ? Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //         child: Text(
                //           'Please select Number of rooms',
                //           style: TextStyle(
                //               fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.delete),
                //         ),
                //       )
                //     : const SizedBox(),
                const SizedBox(
                  height: 16,
                ),
                CommonTextField(
                  controller: _fullNameController,
                  hintText: 'Full name',
                  fillColor: AppColors.textFieldBgColor,
                  onChanged: (v) {
                    context.read<CertificateBloc>().add(SetFullNameEvent(fullName: v));
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CommonTextField(
                  controller: _addressController,
                  hintText: 'Address',
                  fillColor: AppColors.textFieldBgColor,
                  onChanged: (v) {
                    context.read<CertificateBloc>().add(SetAddresseEvent(address: v));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
