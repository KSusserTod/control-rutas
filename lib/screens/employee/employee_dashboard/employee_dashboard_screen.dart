import 'package:control_de_rutas/core/controllers/city_controller.dart';
import 'package:control_de_rutas/core/controllers/employee_controller.dart';
import 'package:control_de_rutas/core/models/employee.dart';
import 'package:control_de_rutas/core/models/resultado.dart';
import 'package:control_de_rutas/screens/employee/employee_dashboard/employee_dashboard_item.dart';
import 'package:control_de_rutas/screens/employee/employee_screen.dart';
import 'package:control_de_rutas/shared/widgets/dropdowns/dropdown_api.dart';
import 'package:control_de_rutas/shared/widgets/textfields/textfield.dart';
import 'package:flutter/material.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> employeeList = [];

  Future<void> loadEmployee() async {
    final Resultado res = (await EmployeeController().getData());
    setState(() {
      employeeList = res.data;
    });
  }

  Future<void> loadEmployeeByCityId() async {
    final Resultado res = (await EmployeeController().getDataByIdCity(
      selectedCity["id"],
    ));
    setState(() {
      employeeList = res.data;
    });
  }

  List<dynamic> citiesList = [];
  dynamic selectedCity;
  dynamic city = {"id": 0, "idEstado": 0, "nombre": "", "estatus": false};

  Future<void> loadCities() async {
    final Resultado res = (await CityController().getData());
    setState(() {
      citiesList = res.data;
    });
  }

  void searchEmployee(String filter) {
    final suggestion =
        employeeList.where((element) {
          final employeeName =
              '${element["nombre"]} ${element["apellidoPaterno"]} ${element["apellidoMaterno"]}'
                  .toLowerCase();
          final input = filter.toLowerCase();

          return employeeName.contains(input);
        }).toList();

    setState(() {
      employeeList = suggestion;
    });
  }

  void clearFilter() {
    searchController.clear();
    selectedCity = null;
    loadEmployee();
  }

  @override
  void initState() {
    loadEmployee();
    loadCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard Empleados")),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownItems(
                        items: citiesList,
                        isEnable: true,
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
                          loadEmployeeByCityId();
                        },
                        validador: (value) {
                          if (value.id == null || value.id == 0) {
                            return "Campo obligatorio, favor de llenar.";
                          }
                          return null;
                        },
                        label: "Seleccione Ciudad",
                        emptyList: "No hay ciudades disponible",
                      ),
                    ),
                    Expanded(
                      child: TextArea(
                        controller: searchController,
                        label: "search route",
                        isEnable: true,
                        onChanged: (value) {
                          if (value == "" && selectedCity != null) {
                            loadEmployeeByCityId();
                          } else if (value == "") {
                            loadEmployee();
                          }
                          searchEmployee(searchController.text);
                        },
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => clearFilter(),
                  child: Text("Limpiar Filtros"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: EmployeeDashboardItem(
                    data: employeeList[index],
                    onEdit: (value) {
                      Employee employee = Employee.fromJson(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => EmployeeScreen(employee: employee),
                        ),
                      ).whenComplete(() => loadEmployee());
                    },
                    onDelete: (value) {
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
                                    "¿Estas seguro que deseas eliminar este registro?",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Ten en cuenta que una vez eliminado no se podrá recuperar.",
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
                                  EmployeeController()
                                      .deleteData(value["id"])
                                      .whenComplete(() => loadEmployee());
                                },
                                child: Text("Confirmar"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => EmployeeScreen(
                    employee: Employee(
                      id: 0,
                      idCiudad: 0,
                      nombre: "",
                      apellidoPaterno: "",
                      apellidoMaterno: "",
                      fechaNacimiento: DateTime.now(),
                      sueldo: 0,
                      status: false,
                    ),
                  ),
            ),
          ).whenComplete(() => loadEmployee());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
