import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_bloc.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_state.dart';

class SelectTemplateWidget extends StatelessWidget {
  SelectTemplateWidget({super.key});

  var selectedTemplate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Choose a template to start the creation.',
            style: TextStyle(
                fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.subHeadingFontColor),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Center(
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppColors.textFieldBgColor, borderRadius: BorderRadius.circular(4)),
            child: ButtonTheme(
              alignedDropdown: true,
              child: BlocBuilder<CertificateBloc, CertificateState>(
                builder: (context, state) {
                  if (state is CertificateSelectedTemplateState) {
                    selectedTemplate = state.newSelectedTemplate;
                  }
                  return DropdownButton<String>(
                    dropdownColor: AppColors.scaffoldBgColor,
                    elevation: 3,
                    borderRadius: BorderRadius.circular(12),
                    underline: const SizedBox(),
                    value: selectedTemplate,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.subHeadingFontColor),
                    onChanged: (String? newValue) {
                      context.read<CertificateBloc>().add(ChooseTemplateEvent(newValue!));
                    },
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    hint: const Text('Choose a template'),
                    items: <String>['Template 1', 'Template 2', 'Template 3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
