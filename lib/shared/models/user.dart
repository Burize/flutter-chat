import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

class IMainUserFields {
  final String firstName;
  final String secondName;
  final String phone;
  final String password;

  IMainUserFields({@required this.firstName, this.secondName, this.phone, this.password});
}

@JsonSerializable(createFactory: true)
class User extends IMainUserFields {
  final String id;

  User({this.id, String firstName, String secondName, String phone, String password})
      : super(firstName: firstName, secondName: secondName, phone: phone, password: password);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
