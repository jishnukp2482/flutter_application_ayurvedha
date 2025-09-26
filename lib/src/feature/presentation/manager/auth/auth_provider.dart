import 'package:flutter/material.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/response_classify.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/request/auth/login_request_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/models/response/auth/login_response_modal.dart';
import 'package:flutter_application_ayurvedha/src/feature/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/routes/app_pages.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/utlities/local_storage_keywords.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/bottom_message.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_print.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  AuthProvider(this.loginUseCase);
  final secureStorage = GetSecureStorage();

  ///login
  ResponseClassify<LoginResponseModel> loginstate =
      ResponseClassify<LoginResponseModel>.error("");
  ResponseClassify<LoginResponseModel> get loginresponse => loginstate;
  final userNameCnltr = TextEditingController();
  final passwordCntlr = TextEditingController();
  final loginDataList = <UserDetails>[];

  getLogin(String username, String password, BuildContext context) async {
    loginstate = ResponseClassify.loading();
    notifyListeners();

    try {
      final loginResponse = await loginUseCase.call(
        LoginRequestModel(username: username, password: password),
      );

      if (loginResponse.status) {
        loginstate = ResponseClassify.completed(loginResponse);

        loginDataList.clear();
        if (loginResponse.userDetails != null) {
          loginDataList.add(loginResponse.userDetails!);
        }

        await secureStorage.write(
          LocalStorageKeyWords.accesstoken,
          loginResponse.token,
        );

        userNameCnltr.clear();
        passwordCntlr.clear();

        bottomMsg(context, "Success", loginResponse.message, true);
        if (loginDataList.isNotEmpty) {
          context.go(AppPages.homePage);
        } else {
          bottomMsg(context, "Failed", "User Details Not Found", false);
        }
      } else {
        loginstate = ResponseClassify.error(loginResponse.message);
        bottomMsg(context, "Failed", loginResponse.message, false);
      }
    } catch (e) {
      loginstate = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      errorPrint("login error = $e");
    }
    notifyListeners();
  }
}
