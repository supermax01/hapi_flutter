import 'fhir_types.dart';
class CarePlan {
  final String id;
  final String status;
  final String intent;
  final String title;
  final List<Activity> activities;

  CarePlan({
    required this.id,
    required this.status,
    required this.intent,
    required this.title,
    required this.activities,
  });

  factory CarePlan.fromJson(Map<String, dynamic> json) {
    return CarePlan(
      id: json['id'] as String,
      status: json['status'] as String,
      intent: json['intent'] as String,
      title: json['title'] as String,
      activities: (json['activity'] as List)
          .map((activity) => Activity.fromJson(activity['detail']))
          .toList(),
    );
  }
}

class Activity {
  final String description;
  final String status;

  Activity({
    required this.description,
    required this.status,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      description: json['description'] as String,
      status: json['status'] as String,
    );
  }
}