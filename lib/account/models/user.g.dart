// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String,
      customerId: json['customerId'] as String,
      displayUid: json['displayUid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      titleCode: json['titleCode'] as String,
      title: json['title'] as String,
      active: json['active'] as bool,
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'customerId': instance.customerId,
      'displayUid': instance.displayUid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'name': instance.name,
      'type': instance.type,
      'titleCode': instance.titleCode,
      'title': instance.title,
      'active': instance.active,
      'selected': instance.selected,
    };
