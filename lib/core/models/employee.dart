class Employee {
  final int id;
  final int idCiudad;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final DateTime fechaNacimiento;
  final double sueldo;
  final bool status;
  final DateTime? fechaCreacion;
  final DateTime? fechaModificacion;
  final DateTime? fechaCancelacion;

  Employee({
    required this.id,
    required this.idCiudad,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.sueldo,
    required this.status,
    this.fechaCreacion,
    this.fechaModificacion,
    this.fechaCancelacion,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    idCiudad: json["idCiudad"],
    nombre: json["nombre"],
    apellidoPaterno: json["apellidoPaterno"],
    apellidoMaterno: json["apellidoMaterno"],
    fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
    sueldo: json["sueldo"]?.toDouble(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idCiudad": idCiudad,
    "nombre": nombre,
    "apellidoPaterno": apellidoPaterno,
    "apellidoMaterno": apellidoMaterno,
    "fechaNacimiento": fechaNacimiento.toIso8601String(),
    "sueldo": sueldo,
    "status": status,
  };
}
