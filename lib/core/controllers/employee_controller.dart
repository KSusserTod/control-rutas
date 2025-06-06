import 'dart:convert';

import 'package:control_de_rutas/core/connection.dart';
import 'package:control_de_rutas/core/models/employee.dart';
import 'package:control_de_rutas/core/models/resultado.dart';

class EmployeeController {
  final ApiConnection apiConnection = ApiConnection();

  Future<Resultado> getData() async {
    final response = await apiConnection.get('/api/Employee');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final res = Resultado.fromJson(jsonData);
      return res;
    } else {
      throw Exception("error");
    }
  }

  Future<Resultado> getDataByIdCity(int id) async {
    final response = await apiConnection.get('/api/Employee/GetByCity/$id');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final res = Resultado.fromJson(jsonData);
      return res;
    } else {
      throw Exception("error");
    }
  }

  Future<Resultado> insertData(Employee employee) async {
    final response = await apiConnection.post(
      '/api/Employee',
      employee.toJson(),
    );
    final jsonData = json.decode(response.body);
    final res = Resultado.fromJson(jsonData);
    return res;
  }

  Future<Resultado> updateData(Employee employee, int id) async {
    final response = await apiConnection.put(
      '/api/Employee/Update/$id',
      employee.toJson(),
    );
    final jsonData = json.decode(response.body);
    final res = Resultado.fromJson(jsonData);
    return res;
  }

  Future<Resultado> deleteData(int id) async {
    final response = await apiConnection.put('/api/Employee/Delete/$id', id);
    final jsonData = json.decode(response.body);
    final res = Resultado.fromJson(jsonData);
    return res;
  }

  Future<Resultado> getDataById(int id) async {
    final response = await apiConnection.get('/api/Employee/id?id=$id');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final res = Resultado.fromJson(jsonData);
      return res;
    } else {
      throw Exception('Error en la búsqueda de datos en la API');
    }
  }
}
