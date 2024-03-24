part of 'certificate_bloc.dart';

sealed class CertificateEvent {}

class ChangeCertifciateCreationStepEvent extends CertificateEvent {
  int currentStep;
  ChangeCertifciateCreationStepEvent(this.currentStep);
}

class ChangeStepOnBackButtomClickEvent extends CertificateEvent {
  int currentStep;
  ChangeStepOnBackButtomClickEvent(this.currentStep);
}

final class loadDataEvent extends CertificateEvent {}

final class ChooseTemplateEvent extends CertificateEvent {
  String selectedTemplate;
  ChooseTemplateEvent(this.selectedTemplate);
}

final class SelectOperationEvent extends CertificateEvent {
  String selectedOperation;
  SelectOperationEvent(this.selectedOperation);
}

final class SelectHousingTypeEvent extends CertificateEvent {
  String selectedHousingType;
  SelectHousingTypeEvent(this.selectedHousingType);
}

final class SelectNumberOfRoomEvent extends CertificateEvent {
  var selectedNumberOfRooms;
  SelectNumberOfRoomEvent(this.selectedNumberOfRooms);
}

final class ResetCertificateEvent extends CertificateEvent {}

final class StartCertificateEvent extends CertificateEvent {
  var selectedNumberOfRooms;
  StartCertificateEvent(this.selectedNumberOfRooms);
}

final class CertificateSwitchClickedEvent extends CertificateEvent {
  bool switchStatus;
  CertificateSwitchClickedEvent(this.switchStatus);
}

final class CertificateAddImagesInListEvent extends CertificateEvent {
  final int _roomId;
  final XFile _roomPicture;

  CertificateAddImagesInListEvent(this._roomId, this._roomPicture);
}

final class LoadOperations extends CertificateEvent {}

final class CreateCertificate extends CertificateEvent {}

final class SetFullNameEvent extends CertificateEvent {
  final String fullName;

  SetFullNameEvent({required this.fullName});
}

final class SetAddresseEvent extends CertificateEvent {
  final String address;

  SetAddresseEvent({required this.address});
}
