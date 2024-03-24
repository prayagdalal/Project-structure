class CertificateModel {
  List<Data>? data;

  CertificateModel({this.data});

  CertificateModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? operationId;
  String? housingType;
  int? noRooms;
  String? fullName;
  String? address;
  bool? localisation;
  String? createdAt;
  List<Images>? images;

  Data(
      {this.id,
      this.userId,
      this.operationId,
      this.housingType,
      this.noRooms,
      this.fullName,
      this.address,
      this.localisation,
      this.createdAt,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    operationId = json['operation_id'];
    housingType = json['housing_type'];
    noRooms = json['no_rooms'];
    fullName = json['full_name'];
    address = json['address'];
    localisation = json['localisation'];
    createdAt = json['created_at'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['operation_id'] = operationId;
    data['housing_type'] = housingType;
    data['no_rooms'] = noRooms;
    data['full_name'] = fullName;
    data['address'] = address;
    data['localisation'] = localisation;
    data['created_at'] = createdAt;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? uuid;
  String? fileName;
  String? size;
  String? url;

  Images({this.id, this.uuid, this.fileName, this.size, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    fileName = json['file_name'];
    size = json['size'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['file_name'] = fileName;
    data['size'] = size;
    data['url'] = url;
    return data;
  }
}
