import 'package:json_annotation/json_annotation.dart';
part 'chat_member.g.dart';

@JsonSerializable(createFactory: true)
class ChatMember {
  final String id;
  final String firstName;
  final String secondName;
  final String avatar;

  String get name {
    if (firstName == null && secondName == null) {
      return 'unknown user';
    }

    return '${firstName ?? ''} ${secondName ?? ''}';
  }

  ChatMember({this.id, this.firstName, this.secondName, this.avatar});

  Map<String, dynamic> toJson() => _$ChatMemberToJson(this);

  factory ChatMember.fromJson(Map<String, dynamic> json) => _$ChatMemberFromJson(json);
}
