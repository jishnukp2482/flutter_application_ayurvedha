import 'package:flutter_application_ayurvedha/src/feature/core/api_provider.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/request/auth/login_request_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/auth/login_response_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/remotes/app_remote_routes.dart';

abstract class AuthAppdataSource {
  Future<LoginResponseModel> getLogin(LoginRequestModel requestModal);
}

class AuthAppdataSourceImpl extends AuthAppdataSource {
  final ApiProvider apiProvider;
  AuthAppdataSourceImpl(this.apiProvider);

  @override
  Future<LoginResponseModel> getLogin(LoginRequestModel requestModal) async {
    return LoginResponseModel.fromJson(
      await apiProvider.post(
        AppRemoteRoutes.signin,
        requestModal.toMap(),
        isFormData: true,
      ),
    );
  }
}
