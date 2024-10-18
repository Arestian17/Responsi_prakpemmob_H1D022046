import 'dart:convert' show json, jsonEncode;
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/keuangan.dart';

class KeuanganBloc {
  static Future<List<Keuangan>> getKeuangans() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.listKeuangan));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          return jsonResponse.map((json) => Keuangan.fromJson(json)).toList();
        } else if (jsonResponse is Map<String, dynamic>) {
          // Jika respons adalah objek tunggal, bungkus dalam list
          return [Keuangan.fromJson(jsonResponse)];
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        throw Exception('Failed to load keuangan data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching keuangan data: $e');
      throw Exception('Error fetching keuangan data: $e');
    }
  }

  static Future addKeuangan({Keuangan? keuangan}) async {
    String apiUrl = ApiUrl.createKeuangan;

    var body = {
      "invesment": keuangan!.investment,
      "value": keuangan.value,
      "portofolio": keuangan.portofolio.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateKeuangan({required Keuangan keuangan}) async {
    String apiUrl = ApiUrl.updateKeuangan(keuangan.id!);
    print(apiUrl);

    var body = {
      "invesment": keuangan.investment,
      "value": keuangan.value,
      "portofolio": keuangan.portofolio.toString()
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteKeuangan({int? id}) async {
    String apiUrl = ApiUrl.deleteKeuangan(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
