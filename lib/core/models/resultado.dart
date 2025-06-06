class Resultado {
  final bool exito;
  final String mensaje;
  final dynamic data;

  Resultado({required this.exito, required this.mensaje, required this.data});

  factory Resultado.fromJson(Map<String, dynamic> json) {
    return Resultado(
      exito: json['exito'],
      mensaje: json['mensaje'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'exito': exito, 'mensaje': mensaje, 'data': data};
  }
}
