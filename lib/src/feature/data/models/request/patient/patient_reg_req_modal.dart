import 'package:dio/dio.dart';

class PatientRegReqModal {
  final String name;
  final String excecutive;
  final String payment;
  final String phone;
  final String address;
  final double total_amount;
  final double discount_amount;
  final double advance_amount;
  final double balance_amount;
  final String date_nd_time; 
  final String id;
  final String male;
  final String female;
  final String branch;
  final String treatments;

  PatientRegReqModal({
    required this.name,
    required this.excecutive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.total_amount,
    required this.discount_amount,
    required this.advance_amount,
    required this.balance_amount,
    required this.date_nd_time,
    this.id = "",
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  // Convert to Map (for easier debugging or JSON use)
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "excecutive": excecutive,
      "payment": payment,
      "phone": phone,
      "address": address,
      "total_amount": total_amount,
      "discount_amount": discount_amount,
      "advance_amount": advance_amount,
      "balance_amount": balance_amount,
      "date_nd_time": date_nd_time,
      "id": id,
      "male": male,
      "female": female,
      "branch": branch,
      "treatments": treatments,
    };
  }

 
  FormData toFormData() {
    return FormData.fromMap(toMap());
  }
}
