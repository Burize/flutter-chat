import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/api_path.dart';

part 'user.g.dart';

class IRegistrationUserFields {
  final String firstName;
  final String secondName;
  final String phone;
  final String password;

  IRegistrationUserFields({
    @required this.firstName,
    @required this.secondName,
    @required this.phone,
    @required this.password,
  });
}

@JsonSerializable(createFactory: true)
class User {
  final String id;
  final String firstName;
  final String secondName;
  final String phone;
  String avatar;

  String get name => '$firstName $secondName';
  String get acronym => '${firstName[0]} ${secondName[0]}'.toUpperCase();

  User({
    @required this.id,
    @required this.firstName,
    @required this.secondName,
    @required this.phone,
    this.avatar,
  });

  ImageProvider getAvatar() {
    if (avatar == null) {
      throw 'try getAvatar on user that has not it';
    }

    return CachedNetworkImageProvider(makeUserAvatarPath(avatar));
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
