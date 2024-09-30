import 'fhir_types.dart';
class Medication {
  final String id;
  final CodeableConcept code;

  Medication({
    required this.id,
    required this.code,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] as String,
      code: CodeableConcept.fromJson(json['code']),
    );
  }
}