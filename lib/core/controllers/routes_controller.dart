import 'dart:convert';

import 'package:control_de_rutas/core/connection.dart';
import 'package:control_de_rutas/core/models/resultado.dart';
import 'package:control_de_rutas/core/models/routes.dart';

class RoutesController {
  final ApiConnection apiConnection = ApiConnection();

  Future<Resultado> getData() async {
    final response = await apiConnection.get('/api/Routes');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final res = Resultado.fromJson(jsonData);
      return res;
    } else {
      throw Exception("error");
    }
  }

  Future<Resultado> getDataByIdCity(int id) async {
    final response = await apiConnection.get('/api/Routes/GetByCity/$id');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final res = Resultado.fromJson(jsonData);
      return res;
    } else {
      throw Exception("error");
    }
  }

  Future<Resultado> insertData(Routes routes) async {
    final response = await apiConnection.post('/api/Routes', routes.toJson());
    final jsonData = json.decode(response.body);
    final res = Resultado.fromJson(jsonData);
    return res;
  }

  Future<Resultado> updateData(Routes routes, int id) async {
    final response = await apiConnection.put('/api/Routes/Update/$id', routes);
    final jsonData = json.decode(response.body);
    final res = Resultado.fromJson(jsonData);
    return res;
  }

  Future<Resultado> deleteData(int id) async {
    final response = await apiConnection.put('/api/Routes/Delete/$id', id);
    final jsonData = json.decode(response.body);
    final res = Resultado.fromJson(jsonData);
    return res;
  }
}
