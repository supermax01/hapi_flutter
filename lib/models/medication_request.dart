import 'fhir_types.dart';
class MedicationRequest {
  final String id;
  final String status;
  final String intent;
  final MedicationReference medicationReference;
  final String authoredOn;
  final DosageInstruction dosageInstruction;

  MedicationRequest({
    required this.id,
    required this.status,
    required this.intent,
    required this.medicationReference,
    required this.authoredOn,
    required this.dosageInstruction,
  });

  factory MedicationRequest.fromJson(Map<String, dynamic> json) {
    return MedicationRequest(
      id: json['id'] as String,
      status: json['status'] as String,
      intent: json['intent'] as String,
      medicationReference: MedicationReference.fromJson(json['medicationReference']),
      authoredOn: json['authoredOn'] as String,
      dosageInstruction: DosageInstruction.fromJson((json['dosageInstruction'] as List).first),
    );
  }
}

class MedicationReference {
  final String reference;

  MedicationReference({required this.reference});

  factory MedicationReference.fromJson(Map<String, dynamic> json) {
    return MedicationReference(
      reference: json['reference'] as String,
    );
  }
}

class DosageInstruction {
  final String text;

  DosageInstruction({required this.text});

  factory DosageInstruction.fromJson(Map<String, dynamic> json) {
    return DosageInstruction(
      text: json['text'] as String,
    );
  }
}