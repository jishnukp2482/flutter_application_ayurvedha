import 'package:flutter_application_ayurvedha/src/feature/data/models/request/auth/login_request_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/auth/login_response_modal.dart';

abstract class AuthRepository {
   Future<LoginResponseModel> getLogin(LoginRequestModel requestModal);
}
