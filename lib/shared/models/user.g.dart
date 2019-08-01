// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    avatar: json['avatar'] as String,
    firstName: json['firstName'] as String,
    secondName: json['secondName'] as String,
    phone: json['phone'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'phone': instance.phone,
      'password': instance.password,
      'id': instance.id,
      'avatar': instance.avatar,
    };
