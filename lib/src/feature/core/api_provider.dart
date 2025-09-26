import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_ayurvedha/src/feature/core/pretty_printer.dart';
import 'package:flutter_application_ayurvedha/src/feature/data/remotes/app_remote_routes.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/utlities/local_storage_keywords.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/widgets/custom/custom_print.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pretty_print_json/pretty_print_json.dart';


import 'custom_exception.dart';

class ApiProvider {
  late Dio _dio;

  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: true,
        headers: {
          "access-control-allow-origin": "*",
          // "Access-Control-Allow-Origin": "*",
          // "Access-Control-Allow-Credentials": false,
          'Content-Type': 'application/json',
        },

        baseUrl: AppRemoteRoutes.baseUrl,

        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
      ),
    );
    if (!kIsWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (
        HttpClient client,
      ) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) async {
          final statusCode = error.response?.statusCode;
          final requestPath = error.requestOptions.path;

          if (statusCode == 403 &&
              !requestPath.contains(AppRemoteRoutes.getRefreshToken)) {
            final newAccessToken = await refreshToken();

            if (newAccessToken != null) {
              final options = error.requestOptions;

              final updatedHeaders = Map<String, dynamic>.from(options.headers);
              updatedHeaders['authorization'] = 'Bearer $newAccessToken';

              final clonedRequest = await _dio.request(
                options.path,
                data: options.data,
                queryParameters: options.queryParameters,
                options: Options(
                  method: options.method,
                  headers: updatedHeaders,
                  contentType: options.contentType,
                  responseType: options.responseType,
                  followRedirects: options.followRedirects,
                  validateStatus: options.validateStatus,
                  receiveDataWhenStatusError:
                      options.receiveDataWhenStatusError,
                ),
              );

              return handler.resolve(clonedRequest);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final getSecureStorage = GetSecureStorage();
    String? accessToken = getSecureStorage.read(
      LocalStorageKeyWords.accesstoken,
    );
    String? refreshToken = getSecureStorage.read(
      LocalStorageKeyWords.refreshToken,
    );

    Map<String, String> headers = {};

    if (accessToken != null) {
      bool isTokenExpired = JwtDecoder.isExpired(accessToken);

      if (!isTokenExpired) {
        headers['authorization'] = 'Bearer $accessToken';
      } else if (refreshToken != null) {
        headers['Cookie'] = 'refreshToken=$refreshToken';
      }

      headers['accessToken'] = accessToken;
      headers['refreshToken'] = refreshToken ?? '';
    }

    return headers;
  }

  Future<String?> refreshToken() async {
    final getsecureStorage = GetSecureStorage();
    String? refreshToken = getsecureStorage.read(
      LocalStorageKeyWords.refreshToken,
    );
    try {
      final response = await _dio.post(
        AppRemoteRoutes.getRefreshToken,
        data: {"refreshToken": refreshToken},
      );
      if (response.statusCode == 200) {
        successPrint("refrehToken calling status code= ${response.statusCode}");
        String newAccessToken = response.data["accessToken"];
        String newRefreshToken = response.data["refreshToken"];
        await getsecureStorage.write(
          LocalStorageKeyWords.accesstoken,
          newAccessToken,
        );
        await getsecureStorage.write(
          LocalStorageKeyWords.refreshToken,
          newRefreshToken,
        );
        _dio.options.headers['authorization'] = 'Bearer $newAccessToken';
        successPrint("refrehToken calling Success");
        return newAccessToken;
      } else if (response.statusCode == 401) {
        prettyPrint("refresh status Code =${response.statusCode ?? ""}");
      } else {
        prettyPrint("login again");
        return null;
      }
    } catch (e) {
      prettyPrint("Refresh token failed: $e");
      return null;
    }

    return null;
  }

  Future<dynamic> get(String endPoint) async {
    try {
      final headers = await getAuthHeaders();
      prettyPrint(_dio.options.headers.toString());
      final Response response = await _dio.get(
        endPoint,
        options: Options(headers: headers),
      );
      prettyPrint("request url : ${response.realUri}");
      final responseData = classifyResponse(response);

      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString(), type: PrettyPrinterTypes.error);
      throw BadRequestException();
    }
  }

  Future<dynamic> delete(String endPoint) async {
    try {
      final headers = await getAuthHeaders();
      prettyPrint(_dio.options.headers.toString());
      final Response response = await _dio.delete(
        endPoint,
        options: Options(headers: headers),
      );
      prettyPrint("getting response ${response.realUri}");
      final responseData = classifyResponse(response);
      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString(), type: PrettyPrinterTypes.error);
      return {};
    }
  }

  Future<dynamic> post(
    String endPoint,
    Map<String, dynamic> body, {
    File? file,
    String fileFieldName = "file",
    bool isFormData = false, 
  }) async {
    prettyPrint("📤 POST Request to: $endPoint");

    try {
      final headers = await getAuthHeaders();
      dynamic requestBody = body;

      
      if (file != null) {
        final formMap = <String, dynamic>{};

       
        body.forEach((key, value) {
          formMap[key] = value.toString();
        });

       
        formMap[fileFieldName] = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );

        requestBody = FormData.fromMap(formMap);
        prettyPrint(
          "📦 Sending as multipart/form-data with file: ${file.path}",
        );
      } else if (isFormData) {
        
        requestBody = FormData.fromMap(
          body.map((k, v) => MapEntry(k, v.toString())),
        );
        prettyPrint("📦 Sending as FormData (no file)");
      } else {
        
        prettyPrint("📨 Sending as raw JSON");
      }

      final Response response = await _dio.post(
        endPoint,
        data: requestBody,
        options: Options(headers: headers),
      );

      prettyPrint(
        "📥 Response from BaseURL : ${response.realUri}\n${response.data}",
      );
      prettyPrint("Statuscode :: ${response.statusCode}");

      return classifyResponse(response);
    } on DioException catch (e) {
      prettyPrint("❌ Error during POST: $e");
      throw FetchDataException("Internet Error");
    }
  }


  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    prettyPrint("on post call");
    try {
      final headers = await getAuthHeaders();
      final Response response = await _dio.put(
        endPoint,
        data: body,
        options: Options(headers: headers),
      );

      final responseData = classifyResponse(response);

      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.message, type: PrettyPrinterTypes.error);
      throw FetchDataException("internetError");
    }
  }

  // Zack
  Future<dynamic> request(String endPoint, FormData formData) async {
    try {
      final headers = await getAuthHeaders();
      prettyPrint(_dio.options.headers.toString());
      final Response response = await _dio.post(
        endPoint,
        data: formData,
        options: Options(headers: headers),
        // options: Options(method: "POST", contentType: "multipart/form-data"),
      );
      prettyPrint("getting response ${response.realUri}");
      final responseData = classifyResponse(response);
      return responseData;
    } on DioException catch (err) {
      prettyPrint(err.toString());
      throw FetchDataException("Internet Error");
    }
  }

  // Future<Uint8List> download({required String imageUrl}) async {
  //   final tempStorage = await getTemporaryDirectory();
  //   final data = await _dio.download(imageUrl, tempStorage.path);
  //   final d = data.data;
  // }

  // Map<String, dynamic> classifyResponse(Response response) {
  dynamic classifyResponse(Response response) {
    if (kDebugMode) {
      print("classifyResponse :: $response");
    }
    if (kDebugMode) {
      print("classifyResponse :: ${response.statusCode} -> ${response.data}");
    }
    // try {
    // final responseData =
    final responseData =
        // response.data as Map<String, dynamic>;
        response.data;
    String errorMsg = "";

    try {
      // errorMsg=responseData["error"][""]
      var error = responseData["errors"];
      var allErrors = error!.map((item) => item["message"]);
      String errorString = "";
      for (var i in allErrors) {
        errorString = "$errorString$i,";
      }
    } catch (e) {
      errorMsg = responseData.toString();
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(errorMsg);
      case 404:
        throw BadRequestException(errorMsg);
      case 401:
        throw UnauthorisedException(errorMsg);
      case 403:
        throw ForbiddenException(errorMsg);
      case 409:
        throw DeleteConflictException(errorMsg);
      case 422:
        throw BadRequestException(errorMsg);
      case 500:
      case 502:
        throw BadRequestException(errorMsg);
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
    // } catch (e) {
    //   throw BadRequestException("something went  wrong");
    // }
  }
}
