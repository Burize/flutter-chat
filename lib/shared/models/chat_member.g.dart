// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMember _$ChatMemberFromJson(Map<String, dynamic> json) {
  return ChatMember(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    secondName: json['secondName'] as String,
    avatar: json['avatar'] as String,
  );
}

Map<String, dynamic> _$ChatMemberToJson(ChatMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'avatar': instance.avatar,
    };
