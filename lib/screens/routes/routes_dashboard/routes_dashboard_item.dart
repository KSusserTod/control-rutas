import 'package:control_de_rutas/shared/widgets/responsiveness/responsive_widget.dart';
import 'package:flutter/material.dart';

class RoutesDashboardItem extends ResponsiveWidget {
  final dynamic data;
  final void Function(dynamic) onEdit;
  final void Function(dynamic) onDelete;
  const RoutesDashboardItem({
    super.key,
    this.data,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget buildDesktop(BuildContext context) =>
      DesktopView(onEdit: onEdit, onDelete: onDelete, data: data);

  @override
  Widget buildMobile(BuildContext context) =>
      MobileView(onEdit: onEdit, onDelete: onDelete, data: data);
}

class DesktopView extends StatelessWidget {
  final dynamic data;
  final void Function(dynamic) onEdit;
  final void Function(dynamic) onDelete;
  const DesktopView({
    super.key,
    this.data,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 150, child: Text('Ruta: ${data["nombre"]}')),
            Text('${data["tipoServicio"]}'),
            SizedBox(
              width: 170,
              child: Text("Capacidad: ${data["capacidad"]}"),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(child: Text(data["id"].toString())),
        ),
        trailing: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onEdit(data),
                  child: const Icon(Icons.edit),
                ),
                GestureDetector(
                  onTap: () => onDelete(data),
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  final dynamic data;
  final void Function(dynamic) onEdit;
  final void Function(dynamic) onDelete;
  const MobileView({
    super.key,
    this.data,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 150, child: Text('Ruta: ${data["nombre"]}')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${data["tipoServicio"]}'),
                Text("Capacidad: ${data["capacidad"]}"),
              ],
            ),
            SizedBox(),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(child: Text(data["id"].toString())),
        ),
        trailing: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onEdit(data),
                  child: const Icon(Icons.edit),
                ),
                GestureDetector(
                  onTap: () => onDelete(data),
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
