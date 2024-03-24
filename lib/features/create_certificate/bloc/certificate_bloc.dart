import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_state.dart';
import 'package:opx_certification/features/create_certificate/repos/certificate_repo.dart';
part 'certificate_event.dart';

enum Status { added, upadated, deleted }

class CertificateBloc extends Bloc<CertificateEvent, CertificateState> {
  var rooms;
  var operation;
  var housingType;
  List<Map<String, dynamic>> selectedPicturesList = [];
  String fullName = '';
  String address = '';

  CertificateBloc() : super(CertificateInitial()) {
    // emit(CertificateInitial());
    on<ChangeCertifciateCreationStepEvent>(changeCertifciateCreationStepEvent);
    on<ChangeStepOnBackButtomClickEvent>(changeStepOnBackButtomClick);
    on<ChooseTemplateEvent>(chooseTemplateEvent);
    on<SelectOperationEvent>(selectOperationEvent);
    on<SelectHousingTypeEvent>(selectHousingTypeEvent);
    on<SelectNumberOfRoomEvent>(selectNumberOfRoomEvent);
    on<ResetCertificateEvent>(resetCertificateEvent);
    on<CertificateSwitchClickedEvent>(certificateSwitchClickedEvent);
    on<StartCertificateEvent>(startCertificateEvent);
    on<CertificateAddImagesInListEvent>(certificateAddImagesInListEvent);
    on<LoadOperations>(loadOperations);
    on<SetAddresseEvent>(setAddresseEvent);
    on<SetFullNameEvent>(setFullNameEvent);
    on<CreateCertificate>(createCertificate);
  }

  FutureOr<void> changeCertifciateCreationStepEvent(
      ChangeCertifciateCreationStepEvent event, Emitter<CertificateState> emit) {
    if (event.currentStep == 2) {
      return null;
    } else {
      emit(CertificateStepChangedState(event.currentStep + 1));
    }
  }

  FutureOr<void> changeStepOnBackButtomClick(ChangeStepOnBackButtomClickEvent event, Emitter<CertificateState> emit) {
    emit(CertificateStepChangedOnBackButtonState(event.currentStep - 1));
  }

  FutureOr<void> chooseTemplateEvent(ChooseTemplateEvent event, Emitter<CertificateState> emit) {
    emit(CertificateSelectedTemplateState(event.selectedTemplate));
  }

  FutureOr<void> selectOperationEvent(SelectOperationEvent event, Emitter<CertificateState> emit) {
    operation = event.selectedOperation;
    log(operation);
    emit(CertificateSelectOperationState(event.selectedOperation));
  }

  FutureOr<void> selectHousingTypeEvent(SelectHousingTypeEvent event, Emitter<CertificateState> emit) {
    housingType = event.selectedHousingType;
    emit(CertificateSelectHousingState(event.selectedHousingType));
  }

  FutureOr<void> selectNumberOfRoomEvent(SelectNumberOfRoomEvent event, Emitter<CertificateState> emit) {
    rooms = event.selectedNumberOfRooms;
    emit(CertificateSelectNumberOfRoomState(event.selectedNumberOfRooms));
  }

  FutureOr<void> resetCertificateEvent(ResetCertificateEvent event, Emitter<CertificateState> emit) {
    rooms = null;
    operation = null;
    housingType = null;
    selectedPicturesList = [];
    fullName = '';
    address = '';
    selectedPicturesList.clear();
    emit(CertificateInitial());
  }

  FutureOr<void> certificateSwitchClickedEvent(CertificateSwitchClickedEvent event, Emitter<CertificateState> emit) {
    emit(CertificateSwitchState(event.switchStatus));
  }

  FutureOr<void> startCertificateEvent(StartCertificateEvent event, Emitter<CertificateState> emit) {}

  FutureOr<void> certificateAddImagesInListEvent(
      CertificateAddImagesInListEvent event, Emitter<CertificateState> emit) {
    bool found = selectedPicturesList.any((element) => element['room_id'] == event._roomId);

    if (found) {
      selectedPicturesList.firstWhere((element) => element['room_id'] == event._roomId)['room_picture'] =
          event._roomPicture;
      emit(ImageAddedOrRemovedInListState(Status.upadated.toString(), event._roomId, event._roomPicture.path));
    } else {
      final Map<String, dynamic> newElement = {
        'room_id': event._roomId,
        'room_picture': event._roomPicture,
      };
      selectedPicturesList.add(newElement);
      emit(ImageAddedOrRemovedInListState(Status.added.toString(), event._roomId, event._roomPicture.path));
    }
  }

  Future<FutureOr<void>> loadOperations(LoadOperations event, Emitter<CertificateState> emit) async {
    try {
      emit(OperationLoadingState());
      var responseData = await CertificateRepo.getOperations();
      if (responseData != null) {
        emit(OperationLoadedSuccessState(operationObject: responseData));
      } else {
        throw Exception('Invalid response data');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> setAddresseEvent(SetAddresseEvent event, Emitter<CertificateState> emit) {
    address = event.address;
    emit(AddressChangedState());
  }

  FutureOr<void> setFullNameEvent(SetFullNameEvent event, Emitter<CertificateState> emit) {
    fullName = event.fullName;
    emit(FullNameChangedState());
  }

  Future<FutureOr<void>> createCertificate(CreateCertificate event, Emitter<CertificateState> emit) async {
    try {
      emit(CertificateCreatingState());
      var responseData = await CertificateRepo.createCertificate(
          operation, housingType, rooms, fullName, address, selectedPicturesList, true);

      if (responseData!.statusCode! >= 200 && responseData.statusCode! <= 300) {
        emit(CertificateCreatedSuccessState());
      } else {
        emit(CertificateCreationErrorState());
      }
    } catch (e) {
      emit(CertificateCreationErrorState());
    }
  }
}
