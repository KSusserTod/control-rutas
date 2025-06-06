import 'package:control_de_rutas/shared/extensions/datetimex.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Datefield extends StatelessWidget {
  final TextEditingController dateController;
  final String? Function(String?)? validator;
  const Datefield({super.key, required this.dateController, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: TextFormField(
          readOnly: true,
          controller: dateController,
          validator: validator,
          onTap: () => onTapFunction(context: context),
          decoration: InputDecoration(
            label: Text("Fecha"),
            hintText: "Ingresa la fecha del evento",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.utc(1900),
      lastDate: DateTime.now(),
    );
    dateController.text = formatDate(pickedDate.toString());
  }

  String formatDate(String date) {
    DateTime datetime = DateTime.parse(date);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(datetime);
  }
}
