
class Puntuacion {
  String name;
  int puntaje;

  Puntuacion({
    required this.name,
    required this.puntaje,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'puntaje': puntaje,
  };

  factory Puntuacion.fromJson(Map<String, dynamic> json) => Puntuacion(
    name: json['name'],
    puntaje: json['puntaje'],
  );
}

