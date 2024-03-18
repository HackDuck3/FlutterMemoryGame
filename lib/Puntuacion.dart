
class Puntuacion {
  String nombre;
  int puntaje;

  Puntuacion({
    required this.nombre,
    required this.puntaje,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'puntaje': puntaje,
  };

  factory Puntuacion.fromJson(Map<String, dynamic> json) => Puntuacion(
    nombre: json['nombre'],
    puntaje: json['puntaje'],
  );
}

