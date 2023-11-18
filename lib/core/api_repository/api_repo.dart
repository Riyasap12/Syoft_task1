import 'api_endpoints.dart';
import 'api_utils.dart';

class ApiRepo {
  login({required String email, required String passWord}) async {
    try {
      final response =
          await ApiUtils().post(url: ApiEndPoints.login, data: {"user_email": email, "user_password": passWord});

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  register(
      {required String firstName,
      required String email,
      required String password,
      required String mobileNumber}) async {
    try {
      final response = await ApiUtils().post(url: ApiEndPoints.register, data: {
        "user_email": email,
        "user_password": password,
        "user_phone": mobileNumber,
        "user_firstname": firstName,
        "user_lastname": "A P",
        "user_city": "Hyderabad",
        "user_zipcode": "500072"
      });

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
