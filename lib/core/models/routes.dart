class Routes {
  final int? id;
  final int idCiudad;
  final int idChofer;
  final String nombre;
  final String tipoServicio;
  final int capacidad;
  final bool estatus;
  final DateTime? fechaCreacion;
  final DateTime? fechaModificacion;
  final DateTime? fechaCancelacion;

  Routes({
    this.id,
    required this.idCiudad,
    required this.idChofer,
    required this.nombre,
    required this.tipoServicio,
    required this.capacidad,
    required this.estatus,
    this.fechaCreacion,
    this.fechaModificacion,
    this.fechaCancelacion,
  });

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
    id: json["id"],
    idCiudad: json["idCiudad"],
    idChofer: json["idChofer"],
    nombre: json["nombre"],
    tipoServicio: json["tipoServicio"],
    capacidad: json["capacidad"],
    estatus: json["estatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idCiudad": idCiudad,
    "idChofer": idChofer,
    "nombre": nombre,
    "tipoServicio": tipoServicio,
    "capacidad": capacidad,
    "estatus": estatus,
  };
}
