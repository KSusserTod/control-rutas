import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiConnection {
  static const String baseUrl = 'https://localhost:7153';
  //static const String baseUrl = 'http://10.0.2.2:7153';

  Future<http.Response> get(String endPoint) async {
    final url = Uri.parse(baseUrl + endPoint);
    final response = await http.get(url);
    return response;
  }

  Future<http.Response> post(String endPoint, dynamic body) async {
    final url = Uri.parse(baseUrl + endPoint);
    final json = jsonEncode(body);
    final header = {'Content-Type': 'application/json'};
    return await http.post(url, body: json, headers: header);
  }

  Future<http.Response> put(String endpoint, dynamic body) async {
    final url = Uri.parse(baseUrl + endpoint);
    final json = jsonEncode(body);
    final header = {'Content-Type': 'application/json'};
    return await http.put(url, body: json, headers: header);
  }
}
