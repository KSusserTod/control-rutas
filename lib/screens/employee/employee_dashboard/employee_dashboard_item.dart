import 'package:control_de_rutas/shared/widgets/responsiveness/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeDashboardItem extends ResponsiveWidget {
  final dynamic data;
  final void Function(dynamic) onEdit;
  final void Function(dynamic) onDelete;
  const EmployeeDashboardItem({
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
    return SizedBox(
      height: 70,
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  '${data["nombre"]} ${data["apellidoPaterno"]} ${data["apellidoMaterno"]}',
                ),
              ),
              Text(formatDate('${data["fechaNacimiento"]}')),
              SizedBox(width: 100, child: Text('${data["sueldo"]}')),
            ],
          ),
          leading: CircleAvatar(child: Text(data["id"].toString())),
          trailing: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              height: 50,
              width: 65,
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
    return SizedBox(
      height: 70,
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    Text(
                      '${data["nombre"]} ${data["apellidoPaterno"]} ${data["apellidoMaterno"]}',
                    ),
                    Text(formatDate('${data["fechaNacimiento"]}')),
                  ],
                ),
              ),
              SizedBox(width: 80, child: Text('\$${data["sueldo"]}')),
            ],
          ),
          leading: CircleAvatar(child: Text(data["id"].toString()), radius: 16),
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
      ),
    );
  }
}

String formatDate(String date) {
  DateTime datetime = DateTime.parse(date);
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  return outputFormat.format(datetime);
}
