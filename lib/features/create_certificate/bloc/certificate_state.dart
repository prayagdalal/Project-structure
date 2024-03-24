import 'package:equatable/equatable.dart';
import 'package:opx_certification/features/create_certificate/models/operations_model.dart';

abstract class CertificateState extends Equatable {
  const CertificateState();

  @override
  List<Object?> get props => [];
}

// Define your state classes
class CertificateInitial extends CertificateState {}

class CertificateStepChangedState extends CertificateState {
  final int newStep;

  const CertificateStepChangedState(this.newStep);

  @override
  List<Object?> get props => [newStep];
}

class CertificateStepChangedOnBackButtonState extends CertificateState {
  final int newStepOnBack;

  const CertificateStepChangedOnBackButtonState(this.newStepOnBack);

  @override
  List<Object?> get props => [newStepOnBack];
}

class CertificateSelectedTemplateState extends CertificateState {
  final String newSelectedTemplate;

  const CertificateSelectedTemplateState(this.newSelectedTemplate);

  @override
  List<Object?> get props => [newSelectedTemplate];
}

class CertificateSelectOperationState extends CertificateState {
  final String newSelectedOperation;

  const CertificateSelectOperationState(this.newSelectedOperation);

  @override
  List<Object?> get props => [newSelectedOperation];
}

class CertificateSelectHousingState extends CertificateState {
  final String newSelectedHousingType;

  const CertificateSelectHousingState(this.newSelectedHousingType);

  @override
  List<Object?> get props => [newSelectedHousingType];
}

class CertificateSelectNumberOfRoomState extends CertificateState {
  final dynamic selectedNumberOfRooms;

  const CertificateSelectNumberOfRoomState(this.selectedNumberOfRooms);

  @override
  List<Object?> get props => [selectedNumberOfRooms];
}

class CertificateSwitchState extends CertificateState {
  final bool newSwitchStatus;

  const CertificateSwitchState(this.newSwitchStatus);

  @override
  List<Object?> get props => [newSwitchStatus];
}

class StartCertificateState extends CertificateState {}

class OperationLoadingState extends CertificateState {}

class OperationLoadedSuccessState extends CertificateState {
  final OperationsModel operationObject;

  const OperationLoadedSuccessState({required this.operationObject});

  @override
  List<Object?> get props => [operationObject];
}

class ImageAddedOrRemovedInListState extends CertificateState {
  final String status;
  final int room_id;
  final String room_image;
  const ImageAddedOrRemovedInListState(this.status, this.room_id, this.room_image);

  @override
  List<Object?> get props => [status, room_id, room_image];
}

class FullNameChangedState extends CertificateState {}

class AddressChangedState extends CertificateState {}

class CertificateCreatingState extends CertificateState {}

class CertificateCreatedSuccessState extends CertificateState {}

class CertificateCreationErrorState extends CertificateState {}
