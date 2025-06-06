import 'package:control_de_rutas/screens/employee/employee_dashboard/employee_dashboard_screen.dart';
import 'package:control_de_rutas/screens/employee/employee_screen.dart';
import 'package:control_de_rutas/screens/routes/routes_dashboard/routes_dashboard_item.dart';
import 'package:control_de_rutas/screens/routes/routes_dashboard/routes_dashboard_screen.dart';
import 'package:control_de_rutas/screens/routes/routes_screen.dart';
import 'package:control_de_rutas/shared/widgets/navigation/nav_drawer/nav_drawer_header.dart';
import 'package:control_de_rutas/shared/widgets/navigation/nav_drawer/nav_drawer_list_tile.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [NavDrawerHeader(), buildMenuItem(context)],
        ),
      ),
    );
  }
}

Widget buildMenuItem(BuildContext context) => Container(
  padding: const EdgeInsets.all(24),
  child: Wrap(
    children: [
      NavDrawerListTile(
        icon: Icons.person,
        title: "Empleados",
        destination: EmployeeDashboardScreen(),
      ),
      NavDrawerListTile(
        icon: Icons.route,
        title: "Rutas",
        destination: RoutesDashboardScreen(),
      ),
    ],
  ),
);
