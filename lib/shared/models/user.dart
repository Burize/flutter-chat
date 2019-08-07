import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/api_path.dart';

part 'user.g.dart';

class IMainUserFields {
  final String firstName;
  final String secondName;
  final String phone;
  final String password;

  IMainUserFields({
    @required this.firstName,
    @required this.secondName,
    @required this.phone,
    @required this.password,
  });
}

@JsonSerializable(createFactory: true)
class User extends IMainUserFields {
  final String id;
  String avatar;

  String get name => '$firstName $secondName';
  String get acronym => '${firstName[0]} ${secondName[0]}'.toUpperCase();

  User({
    @required this.id,
    @required String firstName,
    @required String secondName,
    @required String phone,
    @required String password,
    this.avatar,
  }) : super(firstName: firstName, secondName: secondName, phone: phone, password: password);

  ImageProvider getAvatar() {
    if (avatar == null) {
      throw 'try getAvatar on user that has not it';
    }

    return CachedNetworkImageProvider(makeUserAvatarPath(avatar));
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
