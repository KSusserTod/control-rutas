import 'package:control_de_rutas/core/controllers/city_controller.dart';
import 'package:control_de_rutas/core/controllers/employee_controller.dart';
import 'package:control_de_rutas/core/controllers/routes_controller.dart';
import 'package:control_de_rutas/core/models/city.dart';
import 'package:control_de_rutas/core/models/resultado.dart';
import 'package:control_de_rutas/core/models/routes.dart';
import 'package:control_de_rutas/shared/widgets/buttons/flat_button.dart';
import 'package:control_de_rutas/shared/widgets/dropdowns/dropdown_api.dart';
import 'package:control_de_rutas/shared/widgets/dropdowns/simple_dropdown.dart';
import 'package:control_de_rutas/shared/widgets/textfields/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _routesFormKey = GlobalKey<FormState>();

class RoutesScreen extends StatefulWidget {
  final Routes? data;
  const RoutesScreen({super.key, this.data});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  TextEditingController routeNameController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  String typeService = "Personal";
  bool isNew = true;

  List<dynamic> citiesList = [];
  dynamic selectedCity;
  dynamic city = {"id": 0, "idEstado": 0, "nombre": "", "estatus": false};

  List<dynamic> employeeList = [];
  dynamic selectedEmployee;
  dynamic employee = {
    "id": 0,
    "idCiudad": 0,
    "nombre": "",
    "apellidoPaterno": "",
    "apellidoMaterno": "",
    "estatus": false,
  };

  Future<void> loadCities() async {
    final Resultado res = (await CityController().getData());
    setState(() {
      citiesList = res.data;
    });
  }

  Future<void> loadEmployee(int? id) async {
    final Resultado res = (await EmployeeController().getDataByIdCity(
      id ?? selectedCity["id"],
    ));
    setState(() {
      employeeList = res.data;
    });
  }

  Future<void> getCityById(int id) async {
    final Resultado res = (await CityController().getDataById(id));
    setState(() {
      city = res.data;
    });
  }

  Future<void> getEmployeeById(int id) async {
    final Resultado res = (await EmployeeController().getDataById(id));
    setState(() {
      employee = res.data;
    });
  }

  Future<Resultado> guardarOEditar(int id) async {
    if (id == 0) {
      final route = Routes(
        id: id,
        idCiudad: selectedCity["id"],
        idChofer: selectedEmployee["id"],
        nombre: routeNameController.text,
        tipoServicio: typeService,
        capacidad: int.parse(capacityController.text),
        estatus: true,
      );
      return RoutesController().insertData(route);
    } else {
      final route = Routes(
        idCiudad:
            selectedCity != null ? selectedCity?.id : widget.data!.idCiudad,
        idChofer:
            selectedEmployee != null
                ? selectedEmployee?.id
                : widget.data!.idChofer,
        nombre: routeNameController.text,
        tipoServicio: typeService,
        capacidad: int.parse(capacityController.text),
        estatus: true,
      );
      return RoutesController().updateData(route, id);
    }
  }

  String? validateCapacity(int capacity, String service) {
    if (capacity < 1) {
      return 'La capacidad debe ser siempre mayor que 0';
    }
    if (service == "Articulos") {
      if (capacity > 100) {
        return 'La capacidad Máxima para los articulos es de 100';
      }
    } else if (service == "Personal") {
      if (capacity > 34) {
        return 'La capacidad Máxima para el personal es de 34';
      }
    } else {
      return 'Tipo de servicio no válido.';
    }
    return null;
  }

  @override
  void initState() {
    capacityController.text = 0.toString();
    super.initState();
    loadCities();
    if (widget.data?.id != 0) {
      getCityById(widget.data!.idCiudad);
      getEmployeeById(widget.data!.idChofer);
      loadEmployee(widget.data!.idCiudad);
      routeNameController.text = widget.data!.nombre;
      capacityController.text = widget.data!.capacidad.toString();
      isNew = false;
      typeService = widget.data!.tipoServicio;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Routes Catalogue")),
      body: Center(
        child: Form(
          key: _routesFormKey,
          child: Column(
            children: [
              TextArea(
                controller: routeNameController,
                label: "Nombre de la Ruta",
                isEnable: isNew,
                maxLength: 15,
                filtro: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 ]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
              ),
              SimpleDropdown(
                selectedItem: widget.data!.tipoServicio,
                validador: (value) {
                  if (value == null || value == "") {
                    return "Este campo es obligatorio, favor de llenar.";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    typeService = value;
                    capacityController.clear();
                  });
                },
              ),
              TextArea(
                controller: capacityController,
                label: "Capacidad",
                isEnable: true,
                filtro: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                validator:
                    (value) => validateCapacity(int.parse(value!), typeService),
              ),
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
                  loadEmployee(selectedCity["id"]);
                  if (employeeList.isEmpty) {
                    print("no hay choferes");
                  }
                },
                validador: (value) {
                  if (value["id"] == null || value["id"] == 0) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
                label: "Seleccione",
                emptyList: "No hay chofer disponible",
              ),
              DropdownItems(
                items: employeeList,
                isEnable: true,
                compareFn: (dynamic employee1, dynamic employee2) {
                  if (employee1 == null || employee2 == null) {
                    return false;
                  }
                  return employee1["id"] = employee2["id"];
                },
                itemAsString:
                    (item) =>
                        '${item["nombre"]} ${item["apellidoPaterno"]} ${item["apellidoMaterno"]}',
                selectedItem: employee,
                onChanged: (value) {
                  selectedEmployee = value;
                },
                validador: (value) {
                  if (value["id"] == null || value["id"] == 0) {
                    return "Campo obligatorio, favor de llenar.";
                  }
                  return null;
                },
                label: "Seleccione",
                emptyList: "No hay empleados disponible",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    title: "Guardar",
                    color: Colors.blue,
                    onPressed: () async {
                      if (_routesFormKey.currentState!.validate()) {
                        var res = await guardarOEditar(widget.data!.id!);
                        if (res.exito) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Operación exitosa.")),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Ocurrio un Error.")),
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
}
