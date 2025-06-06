import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isEnable;
  final int? maxLength;
  final List<TextInputFormatter>? filtro;
  final String? Function(String?)? validator;
  final void Function(dynamic)? onChanged;
  const TextArea({
    super.key,
    required this.controller,
    required this.label,
    required this.isEnable,
    this.maxLength,
    this.filtro,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        enabled: isEnable,
        maxLength: maxLength ?? 100,
        inputFormatters: filtro,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        decoration: InputDecoration(
          label: Text(label),
          hintText: "Seleccione",
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
