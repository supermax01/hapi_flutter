import 'fhir_types.dart';
class Condition {
  final String id;
  final String clinicalStatus;
  final CodeableConcept code;

  Condition({
    required this.id,
    required this.clinicalStatus,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      id: json['id'] as String,
      clinicalStatus: json['clinicalStatus']['coding'][0]['display'] as String,
      code: CodeableConcept.fromJson(json['code']),
    );
  }
}

class CodeableConcept {
  final List<Coding> coding;

  CodeableConcept({required this.coding});

  factory CodeableConcept.fromJson(Map<String, dynamic> json) {
    return CodeableConcept(
      coding: (json['coding'] as List)
          .map((coding) => Coding.fromJson(coding))
          .toList(),
    );
  }
}

class Coding {
  final String display;

  Coding({required this.display});

  factory Coding.fromJson(Map<String, dynamic> json) {
    return Coding(
      display: json['display'] as String,
    );
  }
}