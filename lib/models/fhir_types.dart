import 'fhir_types.dart';
class CodeableConcept {
  final List<Coding> coding;

  CodeableConcept({required this.coding});

  factory CodeableConcept.fromJson(Map<String, dynamic> json) {
    return CodeableConcept(
      coding: (json['coding'] as List<dynamic>)
          .map((e) => Coding.fromJson(e))
          .toList(),
    );
  }
}

class Coding {
  final String system;
  final String code;
  final String display;

  Coding({required this.system, required this.code, required this.display});

  factory Coding.fromJson(Map<String, dynamic> json) {
    return Coding(
      system: json['system'] as String,
      code: json['code'] as String,
      display: json['display'] as String,
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
      given: List<String>.from(json['given'] as List<dynamic>),
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
      line: List<String>.from(json['line'] as List<dynamic>),
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
    );
  }
}

class Qualification {
  final CodeableConcept code;

  Qualification({required this.code});

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      code: CodeableConcept.fromJson(json['code']),
    );
  }
}