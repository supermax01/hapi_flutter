import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/patient.dart';
import 'models/medication_request.dart';
import 'models/care_plan.dart';
import 'models/condition.dart';
import 'models/observation.dart';
import 'models/encounter.dart';
import 'models/organization.dart';
import 'models/practitioner.dart';
import 'models/medication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PatientInfoScreen(),
    );
  }
}

class PatientInfoScreen extends StatefulWidget {
  const PatientInfoScreen({super.key});

  @override
  _PatientInfoScreenState createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  Patient? patient;
  List<MedicationRequest> medications = [];
  List<CarePlan> carePlans = [];
  List<Condition> conditions = [];
  List<Observation> observations = [];
  List<Encounter> encounters = [];
  Organization? organization;
  Practitioner? practitioner;
  Medication? medication;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }

  Future<void> fetchPatientData() async {
    // this method is for running on ios simulators
    final url = Uri.parse('http://localhost:8080/fhir/Patient/7/\$everything');

    // this method is for running on android emulators
    // final url = Uri.parse('http://10.0.2.2:8080/fhir/Patient/7/\$everything');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/fhir+json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract all relevant information
        setState(() {
          patient = _extractPatient(data);
          medications = _extractMedications(data);
          carePlans = _extractCarePlans(data);
          conditions = _extractConditions(data);
          observations = _extractObservations(data);
          encounters = _extractEncounters(data);
          organization = _extractOrganization(data);
          practitioner = _extractPractitioner(data);
          medication = _extractMedication(data);

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        debugPrint('Failed to load patient data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching patient data: $e');
    }
  }

  // Extraction Methods
  Patient? _extractPatient(Map<String, dynamic> data) {
    final entry = data['entry']?.firstWhere(
      (entry) => entry['resource']['resourceType'] == 'Patient',
      orElse: () => null,
    );
    return entry != null ? Patient.fromJson(entry['resource']) : null;
  }

  List<MedicationRequest> _extractMedications(Map<String, dynamic> data) {
    return data['entry']
            ?.where((entry) =>
                entry['resource']['resourceType'] == 'MedicationRequest')
            .map<MedicationRequest>(
                (entry) => MedicationRequest.fromJson(entry['resource']))
            .toList() ??
        [];
  }

  List<CarePlan> _extractCarePlans(Map<String, dynamic> data) {
    return data['entry']
            ?.where((entry) => entry['resource']['resourceType'] == 'CarePlan')
            .map<CarePlan>((entry) => CarePlan.fromJson(entry['resource']))
            .toList() ??
        [];
  }

  List<Condition> _extractConditions(Map<String, dynamic> data) {
    return data['entry']
            ?.where((entry) => entry['resource']['resourceType'] == 'Condition')
            .map<Condition>((entry) => Condition.fromJson(entry['resource']))
            .toList() ??
        [];
  }

  List<Observation> _extractObservations(Map<String, dynamic> data) {
    return data['entry']
            ?.where(
                (entry) => entry['resource']['resourceType'] == 'Observation')
            .map<Observation>(
                (entry) => Observation.fromJson(entry['resource']))
            .toList() ??
        [];
  }

  List<Encounter> _extractEncounters(Map<String, dynamic> data) {
    return data['entry']
            ?.where((entry) => entry['resource']['resourceType'] == 'Encounter')
            .map<Encounter>((entry) => Encounter.fromJson(entry['resource']))
            .toList() ??
        [];
  }

  Organization? _extractOrganization(Map<String, dynamic> data) {
    final entry = data['entry']?.firstWhere(
      (entry) => entry['resource']['resourceType'] == 'Organization',
      orElse: () => null,
    );
    return entry != null ? Organization.fromJson(entry['resource']) : null;
  }

  Practitioner? _extractPractitioner(Map<String, dynamic> data) {
    final entry = data['entry']?.firstWhere(
      (entry) => entry['resource']['resourceType'] == 'Practitioner',
      orElse: () => null,
    );
    return entry != null ? Practitioner.fromJson(entry['resource']) : null;
  }

  Medication? _extractMedication(Map<String, dynamic> data) {
    final entry = data['entry']?.firstWhere(
      (entry) => entry['resource']['resourceType'] == 'Medication',
      orElse: () => null,
    );
    return entry != null ? Medication.fromJson(entry['resource']) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Information'),
        backgroundColor: Colors.blue[500],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (patient != null) _buildPatientInfo(patient!),
                    _buildSection(
                        'Medications',
                        medications
                            .map((med) => _buildInfoRow(
                                'Medication:', med.dosageInstruction.text))
                            .toList()),
                    _buildSection(
                        'Care Plans',
                        carePlans
                            .map((plan) =>
                                _buildInfoRow('Care Plan:', plan.title))
                            .toList()),
                    _buildSection(
                        'Conditions',
                        conditions
                            .map((condition) => _buildInfoRow(
                                'Condition:', condition.code.coding[0].display))
                            .toList()),
                    _buildSection(
                        'Observations',
                        observations
                            .map((obs) => _buildInfoRow('Observation:',
                                '${obs.code.coding[0].display} - ${obs.valueQuantity.value} ${obs.valueQuantity.unit}'))
                            .toList()),
                    _buildSection(
                        'Encounters',
                        encounters
                            .map((encounter) => _buildInfoRow('Encounter:',
                                'Started: ${encounter.period.start}'))
                            .toList()),
                    if (organization != null)
                      _buildSection('Organization', [
                        _buildInfoRow('Name:', organization!.name),
                        _buildInfoRow('Address:',
                            organization!.address[0].line.join(', '))
                      ]),
                    if (practitioner != null)
                      _buildSection('Practitioner', [
                        _buildInfoRow(
                            'Name:',
                            practitioner!.name[0].given.join(' ') +
                                ' ' +
                                practitioner!.name[0].family),
                      ]),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPatientInfo(Patient patient) {
    return _buildSection('Patient Information', [
      _buildInfoRow('Name:',
          '${patient.name[0].given.join(' ')} ${patient.name[0].family}'),
      _buildInfoRow('Gender:', patient.gender),
      _buildInfoRow('Birth Date:', patient.birthDate),
    ]);
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
