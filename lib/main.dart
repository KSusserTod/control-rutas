import 'package:control_de_rutas/app.dart';
import 'package:control_de_rutas/screens/employee/employee_screen.dart';
import 'package:control_de_rutas/screens/routes/routes_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: "Control de Rutas - Cormex"),
    );
  }
}
