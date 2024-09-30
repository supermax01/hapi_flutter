import 'fhir_types.dart';
class Observation {
  final String id;
  final CodeableConcept code;
  final Quantity valueQuantity;

  Observation({
    required this.id,
    required this.code,
    required this.valueQuantity,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      id: json['id'] as String,
      code: CodeableConcept.fromJson(json['code']),
      valueQuantity: Quantity.fromJson(json['valueQuantity']),
    );
  }
}

class Quantity {
  final double value;
  final String unit;

  Quantity({required this.value, required this.unit});

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      value: json['value'].toDouble(),
      unit: json['unit'] as String,
    );
  }
}