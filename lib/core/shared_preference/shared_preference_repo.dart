import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syoft_task/model/user_model.dart';

const String _isLoggedIn = 'isLoggedIn';
const String _isFirstTimeUser = 'isFirstTimeUser';
const String _user = 'user';

class SharedPreferenceRepo {
  static late SharedPreferences _pref;
  static SharedPreferenceRepo? _instance;

  SharedPreferenceRepo._(SharedPreferences pref) {
    _pref = pref;
  }
  static SharedPreferenceRepo get instance => _instance!;

  static Future<void> initialize() async {
    _instance ??= SharedPreferenceRepo._(await SharedPreferences.getInstance());
  }

  set isLoggedIn(bool loggedIn) => _pref.setBool(_isLoggedIn, loggedIn);

  bool get isLoggedIn => _pref.getBool(_isLoggedIn) ?? false;
  set isFirstTimeUser(bool data) => _pref.setBool(_isFirstTimeUser, data);

  bool get isFirstTimeUser => _pref.getBool(_isFirstTimeUser) ?? true;

  set storeUserInfo(UserModel user) {
    _pref.setString(_user, jsonEncode(user));
  }

  UserModel get userInfo => UserModel.fromJson(jsonDecode(_pref.getString(_user) ?? ""));

  Future<void> logout() async {
    _pref.clear();
    _pref.setBool(_isLoggedIn, false);
    _pref.setBool(_isFirstTimeUser, false);
  }
}
