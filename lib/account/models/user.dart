import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String uid;
  final String customerId;
  final String displayUid;

  final String firstName;
  final String lastName;
  final String name;

  final String type;
  final String titleCode;
  final String title;

  final bool active;
  final bool selected;

  User({
    required this.uid,
    required this.customerId,
    required this.displayUid,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.type,
    required this.titleCode,
    required this.title,
    required this.active,
    required this.selected,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{uid: $uid, customerId: $customerId, displayUid: $displayUid,'
        'firstName: $firstName, lastName: $lastName, name: $name, '
        'type: $type, titleCode: $titleCode, title: $title, '
        'active: $active, selected: $selected}';
  }
}
