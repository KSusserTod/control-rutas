import 'dart:convert';

import 'package:control_de_rutas/core/connection.dart';
import 'package:control_de_rutas/core/models/resultado.dart';

class CityController {
  final ApiConnection apiConnection = ApiConnection();

  Future<Resultado> getData() async {
    final response = await apiConnection.get('/api/Ciudad');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final res = Resultado.fromJson(jsonData);
      return res;
    } else {
      throw Exception("error");
    }
  }

  Future<Resultado> getDataById(int id) async {
    final response = await apiConnection.get('/api/Ciudad/id?id=$id');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final res = Resultado.fromJson(jsonData);
      return res;
    } else {
      throw Exception('Error en la búsqueda de datos en la API');
    }
  }
}
