import 'package:flutter_application_ayurvedha/src/feature/core/usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/request/auth/login_request_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/auth/login_response_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/repositories/auth/auth_repositories.dart';

class LoginUseCase extends UseCase<LoginResponseModel, LoginRequestModel> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<LoginResponseModel> call(LoginRequestModel params) async {
    return await authRepository.getLogin(params);
  }
}
