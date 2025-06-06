class City {
  late final int id;
  final int idEstado;
  final String name;
  final bool estatus;

  City({
    required this.id,
    required this.idEstado,
    required this.name,
    required this.estatus,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['id'],
    idEstado: json['idEstado'],
    name: json['nombre'],
    estatus: json['estatus'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idEstado": idEstado,
    "nombre": name,
    "estatus": estatus,
  };
}
