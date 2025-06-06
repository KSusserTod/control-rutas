import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SimpleDropdown extends StatelessWidget {
  final dynamic selectedItem;
  final void Function(dynamic)? onChanged;
  final String Function(dynamic)? itemAsString;
  final bool Function(dynamic, dynamic)? compareFn;
  final String? Function(dynamic)? validador;
  final String? label;
  const SimpleDropdown({
    super.key,
    this.selectedItem,
    this.onChanged,
    this.itemAsString,
    this.label,
    this.compareFn,
    this.validador,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: DropdownSearch<String>(
        compareFn: compareFn,
        items: (filter, loadProps) => ["Personal", "Articulos"],
        itemAsString: itemAsString,
        selectedItem: selectedItem,
        onChanged: onChanged,
        validator: validador,
        popupProps: const PopupProps.menu(),
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            label: Text(label ?? ""),
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
        ),
      ),
    );
  }
}
