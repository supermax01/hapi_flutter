import 'fhir_types.dart';

class Practitioner {
  final String id;
  final List<HumanName> name;

  Practitioner({
    required this.id,
    required this.name,
  });

  factory Practitioner.fromJson(Map<String, dynamic> json) {
    return Practitioner(
      id: json['id'] as String,
      name: (json['name'] as List<dynamic>)
          .map((e) => HumanName.fromJson(e))
          .toList(),
    );
  }
}