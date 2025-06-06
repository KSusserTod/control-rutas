import 'package:control_de_rutas/core/controllers/city_controller.dart';
import 'package:control_de_rutas/core/controllers/employee_controller.dart';
import 'package:control_de_rutas/core/controllers/routes_controller.dart';
import 'package:control_de_rutas/core/models/resultado.dart';
import 'package:control_de_rutas/core/models/routes.dart';
import 'package:control_de_rutas/screens/employee/employee_dashboard/employee_dashboard_item.dart';
import 'package:control_de_rutas/screens/employee/employee_screen.dart';
import 'package:control_de_rutas/screens/routes/routes_dashboard/routes_dashboard_item.dart';
import 'package:control_de_rutas/screens/routes/routes_screen.dart';
import 'package:control_de_rutas/shared/widgets/dropdowns/dropdown_api.dart';
import 'package:control_de_rutas/shared/widgets/textfields/textfield.dart';
import 'package:flutter/material.dart';

class RoutesDashboardScreen extends StatefulWidget {
  const RoutesDashboardScreen({super.key});

  @override
  State<RoutesDashboardScreen> createState() => _RoutesDashboardScreenState();
}

class _RoutesDashboardScreenState extends State<RoutesDashboardScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> routesList = [];

  Future<void> loadRoutes() async {
    final Resultado res = (await RoutesController().getData());
    setState(() {
      routesList = res.data;
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

  Future<void> loadRoutesByCityId() async {
    final Resultado res = (await RoutesController().getDataByIdCity(
      selectedCity["id"],
    ));
    setState(() {
      routesList = res.data;
    });
  }

  void searchCity(String filter) {
    final suggestion =
        routesList.where((element) {
          final cityName = '${element["nombre"]}'.toLowerCase();
          final input = filter.toLowerCase();

          return cityName.contains(input);
        }).toList();

    setState(() {
      routesList = suggestion;
    });
  }

  void clearFilter() {
    searchController.clear();
    selectedCity = null;
    loadRoutes();
  }

  @override
  void initState() {
    loadRoutes();
    loadCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard rutas")),
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
                          loadRoutesByCityId();
                        },
                        validador: (value) {
                          if (value.id == null || value.id == 0) {
                            return "Campo obligatorio, favor de llenar.";
                          }
                          return null;
                        },
                        label: "Seleccione",
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
                            loadRoutesByCityId();
                          } else if (value == "") {
                            loadRoutes();
                          }
                          searchCity(searchController.text);
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
              itemCount: routesList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: RoutesDashboardItem(
                    data: routesList[index],
                    onEdit: (value) {
                      Routes routes = Routes.fromJson(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoutesScreen(data: routes),
                        ),
                      ).whenComplete(() => loadRoutes());
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
                                  RoutesController()
                                      .deleteData(value["id"])
                                      .whenComplete(() => loadRoutes());
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
                  (context) => RoutesScreen(
                    data: Routes(
                      id: 0,
                      idCiudad: 0,
                      idChofer: 0,
                      nombre: "",
                      tipoServicio: "",
                      capacidad: 0,
                      estatus: false,
                    ),
                  ),
            ),
          ).whenComplete(() => loadRoutes());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
