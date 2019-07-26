import 'dart:convert';

import 'package:flutter_chat/shared/models/chat_member.dart';

List<ChatMember> convertUserFromResponse(String json) {
  final members = jsonDecode(json);
  return (members as List).map((member) => ChatMember.fromJson(member)).toList();
}
