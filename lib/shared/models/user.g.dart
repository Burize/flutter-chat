// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    secondName: json['secondName'] as String,
    phone: json['phone'] as String,
    avatar: json['avatar'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'phone': instance.phone,
      'avatar': instance.avatar,
    };
