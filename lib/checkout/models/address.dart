import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  final String id;
  final String firstName;
  final String lastName;
  final String line1;
  final String? line2;
  final String town;
  final Region? region;
  final Country country;
  final String postalCode;
  final bool defaultAddress;

  Address({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.line1,
    this.line2,
    required this.town,
    this.region,
    required this.country,
    required this.postalCode,
    required this.defaultAddress,
  });

  String get multiLineFormat {
    return '''$firstName $lastName
$line1
$town${region != null ? ', ${region!.isocode}' : ''}, ${country.isocode}
$postalCode''';
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return 'Address{firstName: $firstName, lastName: $lastName, line1: $line1, line2: $line2, town: $town, region: $region, country: $country, postalCode: $postalCode, defaultAddress: $defaultAddress}';
  }
}

@JsonSerializable()
class Country {
  final String isocode;

  Country({required this.isocode});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  String toString() {
    return 'Country{isocode: $isocode}';
  }
}

@JsonSerializable()
class Region {
  final String isocode;

  Region({required this.isocode});

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);

  @override
  String toString() {
    return 'Region{isocode: $isocode}';
  }
}
