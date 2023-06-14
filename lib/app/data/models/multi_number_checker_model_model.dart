class MultiNumberCheckerModel {
  bool? success;
  List<MyContactModel>? message;

  MultiNumberCheckerModel({this.success, this.message});

  MultiNumberCheckerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      message = <MyContactModel>[];
      json['message'].forEach((v) {
        message?.add(MyContactModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (message != null) {
      data['message'] = message?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyContactModel {
  String? phone;
  String? sId;
  String? name;
  String? profilePicture;
  String? gender;
  String? country;
  int? birth;
  String? about;
  bool? isVideoCallAllowed;
  int? createdAt;
  int? updatedAt;
  int? iV;
  String? status;

  MyContactModel(
      {this.phone,
      this.sId,
      this.name,
      this.profilePicture,
      this.gender,
      this.country,
      this.birth,
      this.about,
      this.isVideoCallAllowed,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.status});

  MyContactModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    gender = json['gender'];
    country = json['country'];

    birth = json['birth'];
    about = json['about'];
    isVideoCallAllowed = json['isVideoCallAllowed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['_id'] = sId;
    data['name'] = name;
    data['profilePicture'] = profilePicture;
    data['gender'] = gender;

    data['country'] = country;
    data['birth'] = birth;
    data['about'] = about;
    data['isVideoCallAllowed'] = isVideoCallAllowed;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['status'] = status;
    return data;
  }
}
