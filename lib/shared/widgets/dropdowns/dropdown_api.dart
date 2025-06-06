import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownItems extends StatelessWidget {
  final List<dynamic> items;
  final dynamic selectedItem;
  final void Function(dynamic)? onChanged;
  final String Function(dynamic)? itemAsString;
  final bool Function(dynamic, dynamic)? compareFn;
  final String? label;
  final String emptyList;
  final String? Function(dynamic)? validador;
  final bool isEnable;
  const DropdownItems({
    super.key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.itemAsString,
    this.label,
    this.compareFn,
    this.validador,
    required this.isEnable,
    required this.emptyList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: DropdownSearch<dynamic>(
        enabled: isEnable,
        compareFn: compareFn,
        items: (filter, loadProps) => items,
        itemAsString: itemAsString,
        selectedItem: selectedItem,
        onChanged: onChanged,
        popupProps: PopupProps.menu(
          emptyBuilder:
              (context, searchEntry) => Center(child: Text(emptyList)),
        ),
        validator: validador,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            label: Text(label ?? ""),
            hintText: "Seleccione",
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
