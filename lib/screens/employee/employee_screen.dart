import 'package:control_de_rutas/core/controllers/city_controller.dart';
import 'package:control_de_rutas/core/controllers/employee_controller.dart';
import 'package:control_de_rutas/core/models/employee.dart';
import 'package:control_de_rutas/core/models/resultado.dart';
import 'package:control_de_rutas/shared/extensions/datetimex.dart';
import 'package:control_de_rutas/shared/widgets/buttons/flat_button.dart';
import 'package:control_de_rutas/shared/widgets/dropdowns/dropdown_api.dart';
import 'package:control_de_rutas/shared/widgets/textfields/datefield.dart';
import 'package:control_de_rutas/shared/widgets/textfields/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final _employeeFormKey = GlobalKey<FormState>();

class EmployeeScreen extends StatefulWidget {
  final Employee? employee;
  const EmployeeScreen({super.key, this.employee});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController lastNamController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<dynamic> citiesList = [];
  dynamic selectedCity;
  dynamic city = {"id": 0, "idEstado": 0, "nombre": "", "estatus": false};
  bool isNew = true;

  Future<void> loadCities() async {
    final Resultado res = (await CityController().getData());
    setState(() {
      citiesList = res.data;
    });
  }

  Future<void> getCityById(int id) async {
    final Resultado res = (await CityController().getDataById(id));
    setState(() {
      city = res.data;
    });
  }

  Future<Resultado> guardarOEditar(int id) async {
    if (id == 0) {
      final employee = Employee(
        id: id,
        idCiudad: selectedCity["id"],
        nombre: nameController.text,
        apellidoPaterno: lastNameController.text,
        apellidoMaterno: lastNamController.text,
        fechaNacimiento: DateTime.parse("${dateController.text} 00:00:00.000"),
        sueldo: double.parse(salaryController.text),
        status: true,
      );
      return EmployeeController().insertData(employee);
    } else {
      final employee = Employee(
        id: id,
        idCiudad:
            selectedCity != null ? selectedCity?.id : widget.employee!.idCiudad,
        nombre: nameController.text,
        apellidoPaterno: lastNameController.text,
        apellidoMaterno: lastNamController.text,
        fechaNacimiento: DateTime.parse("${dateController.text} 00:00:00"),
        sueldo: double.parse(salaryController.text),
        status: true,
      );
      return EmployeeController().updateData(employee, id);
    }
  }

  @override
  void initState() {
    super.initState();
    loadCities();
    if (widget.employee?.id != 0) {
      getCityById(widget.employee!.idCiudad);
      nameController.text = widget.employee!.nombre;
      lastNameController.text = widget.employee!.apellidoPaterno;
      lastNamController.text = widget.employee!.apellidoMaterno;
      salaryController.text = widget.employee!.sueldo.toString();
      dateController.text = formatDate(
        widget.employee!.fechaNacimiento.toString(),
      );
      isNew = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Catalogue")),
      body: Center(
        child: Form(
          key: _employeeFormKey,
          child: Column(
            children: [
              DropdownItems(
                items: citiesList,
                isEnable: isNew,
                compareFn: (dynamic city1, dynamic city2) {
                  if (city1 == null || city2 == null) {
                    return false;
                  }
                  return city1.id = city2.id;
                },
                itemAsString: (item) => item['nombre'],
                selectedItem: city,
                onChanged: (value) {
                  selectedCity = value;
                },
                validador: (value) {
                  if (value["id"] == null || value["id"] == 0) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
                label: "Seleccione",
                emptyList: "No hay ciudades disponible",
              ),
              TextArea(
                controller: nameController,
                label: 'Nombre(s)',
                isEnable: isNew,
                maxLength: 15,
                filtro: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
              ),
              TextArea(
                controller: lastNameController,
                label: 'Apellido Paterno',
                isEnable: isNew,
                maxLength: 15,
                filtro: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
              ),
              TextArea(
                controller: lastNamController,
                label: 'Apellido Materno',
                isEnable: isNew,
                maxLength: 15,
                filtro: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
              ),
              Datefield(
                dateController: dateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Este campo es obligatorio, favor de llenar.";
                  }
                  if (DateTime.parse(
                    "${dateController.text} 00:00:00",
                  ).isUnderage()) {
                    return "El empleado no cumple la mayoría de edad. Verifíca la fecha.";
                  } else {
                    return null;
                  }
                },
              ),
              TextArea(
                controller: salaryController,
                label: 'Sueldo',
                isEnable: true,
                filtro: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    title: "Guardar",
                    color: Colors.blue,
                    onPressed: () async {
                      if (_employeeFormKey.currentState!.validate()) {
                        var res = await guardarOEditar(widget.employee!.id);
                        if (res.exito) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Operación exitosa.")),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Ocurrio un error.")),
                          );
                        }
                      }
                    },
                  ),
                  FlatButton(
                    title: "Salir",
                    color: Colors.grey,
                    onPressed: () {
                      bool res = false;
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            title: Text("Atención"),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                    "¿Estas seguro que deseas salir del formulario?",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Tu progreso no quedará guardado y se perderá.",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    res = true;
                                  });
                                },
                                child: Text("Confirmar"),
                              ),
                            ],
                          );
                        },
                      ).whenComplete(() {
                        if (res) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String date) {
    DateTime datetime = DateTime.parse(date);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(datetime);
  }
}
