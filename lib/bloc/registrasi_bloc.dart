import 'package:http/http.dart' as http;
import 'dart:convert';
import '/helpers/api_url.dart';

class RegistrasiBloc {
  static Future<bool> registrasi({required String nama, required String email, required String password}) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {"nama": nama, "email": email, "password": password};
    try {
      var response = await http.post(Uri.parse(apiUrl), body: json.encode(body), headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during API call: $e');
      return false;
    }
  }
}
