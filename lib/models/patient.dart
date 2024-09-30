import 'fhir_types.dart';
class Patient {
  final String id;
  final String gender;
  final String birthDate;
  final List<HumanName> name;
  final List<Address> address;

  Patient({
    required this.id,
    required this.gender,
    required this.birthDate,
    required this.name,
    required this.address,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      gender: json['gender'] as String,
      birthDate: json['birthDate'] as String,
      name: (json['name'] as List).map((e) => HumanName.fromJson(e)).toList(),
      address: (json['address'] as List).map((e) => Address.fromJson(e)).toList(),
    );
  }
}

class HumanName {
  final String family;
  final List<String> given;

  HumanName({required this.family, required this.given});

  factory HumanName.fromJson(Map<String, dynamic> json) {
    return HumanName(
      family: json['family'] as String,
      given: List<String>.from(json['given'] as List),
    );
  }
}

class Address {
  final List<String> line;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.line,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      line: List<String>.from(json['line'] as List),
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
    );
  }
}