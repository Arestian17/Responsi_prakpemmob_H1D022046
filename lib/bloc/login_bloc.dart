import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/api_url.dart';
import '../helpers/user_info.dart';

class LoginBloc {
  static Future<LoginResponse> login({required String email, required String password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"}
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        String token = jsonObj['token'] ?? '';
        String userID = jsonObj['user']['id'].toString();
        await UserInfo().setToken(token);
        await UserInfo().setUserID(userID);
        return LoginResponse(success: true, token: token, userID: userID);
      } else {
        return LoginResponse(success: false, message: 'Login failed');
      }
    } catch (e) {
      print('Error during login: $e');
      return LoginResponse(success: false, message: 'Error: $e');
    }
  }
}

class LoginResponse {
  final bool success;
  final String? token;
  final String? userID;
  final String? message;

  LoginResponse({required this.success, this.token, this.userID, this.message});
}
