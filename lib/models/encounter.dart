import 'fhir_types.dart';
class Encounter {
  final String id;
  final String status;
  final Period period;

  Encounter({
    required this.id,
    required this.status,
    required this.period,
  });

  factory Encounter.fromJson(Map<String, dynamic> json) {
    return Encounter(
      id: json['id'] as String,
      status: json['status'] as String,
      period: Period.fromJson(json['period']),
    );
  }
}

class Period {
  final String start;
  final String end;

  Period({required this.start, required this.end});

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      start: json['start'] as String,
      end: json['end'] as String,
    );
  }
}