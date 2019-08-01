import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/api_path.dart';

part 'chat_member.g.dart';

@JsonSerializable(createFactory: true)
class ChatMember {
  final String id;
  final String firstName;
  final String secondName;
  final String avatar;

  String get name => '$firstName $secondName';
  String get acronym => '${firstName[0]} ${secondName[0]}'.toUpperCase();

  ChatMember({@required this.id, @required this.firstName, @required this.secondName, this.avatar});

  ImageProvider getAvatar() {
    if (avatar == null) {
      throw 'try getAvatar on user that has not it';
    }

    return CachedNetworkImageProvider(makeUserAvatarPath(avatar));
  }

  Map<String, dynamic> toJson() => _$ChatMemberToJson(this);

  factory ChatMember.fromJson(Map<String, dynamic> json) => _$ChatMemberFromJson(json);
}
