import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:opx_certification/features/create_certificate/models/certificate_model.dart';
import 'package:opx_certification/features/create_certificate/repos/certificate_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadAllCertificatesEvent>(loadAllCertificatesEvent);
  }

  Future<FutureOr<void>> loadAllCertificatesEvent(LoadAllCertificatesEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      var responseData = await CertificateRepo.getCertificates();
      if (responseData != null) {
        emit(HomeLoaded(certificateModel: responseData));
      } else {
        throw Exception('Invalid response data');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
