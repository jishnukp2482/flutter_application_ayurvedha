import 'package:dio/dio.dart';

class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }

  FormData toFormData() {
    return FormData.fromMap(toMap());
  }
}
