class GetAUserModel {
  bool? success;
  Message? message;

  GetAUserModel({this.success, this.message});

  GetAUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? Message?.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (message != null) {
      data['message'] = message?.toJson();
    }
    return data;
  }
}

class Message {
  String? sId;
  String? name;
  String? phone;
  String? profilePicture;
  String? gender;
  String? country;
  int? birth;
  String? about;
  bool? isVideoCallAllowed;
  int? createdAt;
  int? updatedAt;
  int? iV;

  Message(
      {this.sId,
      this.name,
      this.phone,
      this.profilePicture,
      this.gender,
      this.country,
      this.birth,
      this.about,
      this.isVideoCallAllowed,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    profilePicture = json['profilePicture'];
    gender = json['gender'];
    country = json['country'];
    birth = json['birth'];
    about = json['about'];
    isVideoCallAllowed = json['isVideoCallAllowed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['profilePicture'] = profilePicture;
    data['gender'] = gender;
    data['country'] = country;
    data['birth'] = birth;
    data['about'] = about;
    data['isVideoCallAllowed'] = isVideoCallAllowed;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
