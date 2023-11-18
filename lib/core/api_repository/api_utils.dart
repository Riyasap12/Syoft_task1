import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:syoft_task/common_widget/snck_bar.dart';
import 'package:syoft_task/core/shared_preference/shared_preference_repo.dart';
import 'package:syoft_task/screen/auth/auth.dart';
import 'api.dart';
import 'custom_log_interceptor.dart';

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  static final ApiUtils _apiUtils = ApiUtils._i();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Api.baseUrl,
      sendTimeout: 60000,
      connectTimeout: 60000,
      validateStatus: (status) => true,
    ),
  );

  ApiUtils._i() {
    _dio.interceptors
      ..add(AppInterceptor())
      ..add(CustomLogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ));
  }

  factory ApiUtils() {
    return _apiUtils;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {"Content-Type": "application/json", "api-version": "1"};

  Map<String, String> secureHeaders = {"Content-Type": "application/json", "api-version": "1", "Authorization": ""};

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Sending FormData:
    //FormData formData = FormData.fromMap({"name": ""});

    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> patch({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    // ProgressCallback? onSendProgress,
  }) async {
    //
    var result = await _dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      // onSendProgress: onSendProgress,
    );
    return result;
  }

  Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Options options = Options(headers: secureHeaders);

    //var result = await _dio.delete(api, options: options);
    var result = await _dio.delete(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }
}

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(message: "No Internet!");
    } else {
      try {
        // if (SharedPreferenceRepo.instance.isLoggedIn == true) {
        //   options.headers["Authorization"] = "Bearer ${SharedPreferenceRepo.instance.authToken}";
        // }

        handler.next(options);
      } catch (e) {
        //print('AppInterceptor Error : ${e.toString()}');
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    switch (response.statusCode) {
      case 401:
        {
          await SharedPreferenceRepo.instance.logout();
          Get.offAll(() => AuthScreen());
        }
        break;
      // check forbidden access
      case 403:
        {
          ///add this
          await SharedPreferenceRepo.instance.logout();
          Get.offAll(() => const AuthScreen());
        }
        break;
      case 500:
        {}
        break;
    }
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    log(err.toString());
    if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to a network.
      customSnackBar(message: 'Check your internet Connection! and Try again');
    } else {
      if (err.type == DioErrorType.connectTimeout) {
        customSnackBar(message: "Server Down");
      } else {
        switch (err.response?.statusCode) {
          // check unauthorize access
          case 401:
            {
              await SharedPreferenceRepo.instance.logout();
              Get.offAll(() => const AuthScreen());
            }
            break;
          // check forbidden access
          case 403:
            {
              await SharedPreferenceRepo.instance.logout();
              Get.offAll(() => const AuthScreen());
            }
            break;
          case 500:
            {}
            break;
        }
      }
    }

    handler.next(err);
  }
}
