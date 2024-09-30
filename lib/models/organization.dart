import 'fhir_types.dart';

class Organization {
  final String id;
  final String name;
  final List<Address> address;

  Organization({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as String,
      name: json['name'] as String,
      address: (json['address'] as List)
          .map((e) => Address.fromJson(e))
          .toList(),
    );
  }
}