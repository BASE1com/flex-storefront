// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String?,
      titleCode: json['titleCode'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      line1: json['line1'] as String,
      line2: json['line2'] as String?,
      town: json['town'] as String,
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
      postalCode: json['postalCode'] as String,
      defaultAddress: json['defaultAddress'] as bool,
      cellphone: json['cellphone'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'titleCode': instance.titleCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'line1': instance.line1,
      'line2': instance.line2,
      'town': instance.town,
      'region': instance.region?.toJson(),
      'country': instance.country.toJson(),
      'postalCode': instance.postalCode,
      'defaultAddress': instance.defaultAddress,
      'cellphone': instance.cellphone,
      'phone': instance.phone,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      isocode: json['isocode'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'isocode': instance.isocode,
      'name': instance.name,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      isocode: json['isocode'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'isocode': instance.isocode,
      'name': instance.name,
    };
