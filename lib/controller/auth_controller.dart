import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:syoft_task/common_widget/snck_bar.dart';
import 'package:syoft_task/core/api_repository/api_repo.dart';
import 'package:syoft_task/core/shared_preference/shared_preference_repo.dart';
import 'package:syoft_task/model/user_model.dart';
import 'package:syoft_task/screen/home/home.dart';

class AuthController extends GetxController {
  String hash = "";
  String mobileNumber = "";
  bool isLogin = false;
  bool isVerifiying = false;
  bool isRegisteriying = false;
  UserModel? user;
  bool isUserDataLoading = false;
  final pref = SharedPreferenceRepo.instance;
  List<UserModel> userModel = [];
  login({required String email, required String passWord}) async {
    isLogin = true;
    update();
    try {
      final Response response = await ApiRepo().login(email: email, passWord: passWord);
      if (response.statusCode == 200) {
        if (response.data != null) {
          var data = jsonDecode(response.data);
          if (data['status'] == true) {
            if (data['user_data'] is List) {
              if (data['user_data'].length != 0) {
                user = UserModel.fromJson(data['user_data'].first);
                pref.storeUserInfo = user!;
                pref.isLoggedIn = true;

                Get.offAll(() => MainScreen());
                customSnackBar(message: "Login successfully", snackBarType: SnackBarType.success);
              } else {
                customSnackBar(message: "Login Failed");
              }
            } else {
              customSnackBar(message: "Login Failed");
            }
          } else {
            customSnackBar(message: data['msg'].toString());
          }
        }
      } else {
        customSnackBar(message: "Login Failed");
      }
    } catch (e) {
      log(e.toString());
      // rethrow;
    } finally {
      isLogin = false;
      update();
    }
  }

  register(
      {required String firstName,
      required String email,
      required String password,
      required String mobileNumber}) async {
    isRegisteriying = true;
    update();
    try {
      final Response response =
          await ApiRepo().register(email: email, firstName: firstName, mobileNumber: mobileNumber, password: password);
      if (response.statusCode == 200) {
        if (response.data != null) {
          var data = jsonDecode(response.data);
          if (data['status'] == true) {
            customSnackBar(message: data['msg'], snackBarType: SnackBarType.success);
            await login(email: email, passWord: password);
          } else {
            customSnackBar(message: data['msg']);
          }
        } else {
          customSnackBar(message: "Registration Failed");
        }
      } else {
        customSnackBar(message: "Registration Failed");
      }
    } catch (e) {
      // dialogBoxCustoms(content: "Something went wrong, Please retry");
    } finally {
      isRegisteriying = false;
      update();
    }
  }
}
