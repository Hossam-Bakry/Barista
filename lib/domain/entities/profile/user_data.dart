import 'package:flutter/material.dart';

class UserData {
  String? userName;
  String? phoneNumber;
  String? birthday;
  String? gender;
  String? profilePic;
  String? email;
  String? imagePath;
  String? country;
  String? originalCountry;

  UserData._({
    this.userName,
    this.profilePic,
    this.email,
    this.phoneNumber,
    this.birthday,
    this.gender,
    this.imagePath,
    this.country,
    this.originalCountry,
  });

  factory UserData() {
    _this ??= UserData._();
    return _this!;
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    if (_this == null) {
      _this = UserData._(
        userName: json["data"]["userName"],
        email: json['data']['email'],
        phoneNumber: json['data']['phoneNumber'],
        profilePic: json["data"]["imagePath"],
        birthday: json["data"]["birthDate"],
        gender: json["data"]["gender"],
        imagePath: json["data"]["imagePath"],
        country: json["data"]["country"],
        originalCountry: json["data"]["originalCountry"],
      );
    } else {
      _this!.userName = json['data']['userName'];
      _this!.email = json['data']['email'];
      _this!.phoneNumber = json['data']['phoneNumber'];
      _this!.profilePic = json['data']['imagePath'];
      _this!.birthday = json['data']['birthDate'];
      _this!.gender = json['data']['gender'];
      _this!.imagePath = json['data']['imagePath'];
      _this!.country = json['data']['country'];
      _this!.originalCountry = json['data']['originalCountry'];
    }

    return _this!;
  }

  static printUser() {
    debugPrint(_this!.userName);
    debugPrint(_this!.email);
    debugPrint(_this!.phoneNumber);
    debugPrint(_this!.profilePic);
    debugPrint(_this!.gender);
    debugPrint(_this!.birthday.toString());
    debugPrint(_this!.imagePath.toString());
    debugPrint(_this!.country.toString());
  }

  clearUser() {
    userName = null;
    email = null;
    profilePic = null;
    phoneNumber = null;
    gender = null;
    birthday = null;
    country = null;
    imagePath = null;
  }

  static UserData? _this;
}
