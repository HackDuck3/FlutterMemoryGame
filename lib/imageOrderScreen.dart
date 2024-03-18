import 'package:flutter/material.dart';
import 'package:flutter_application_1/scores.dart';
import 'package:flutter_application_1/rankingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrdenarImagenesScreen extends StatefulWidget {
  final String name;
  final List<String> secuencia;

  const OrdenarImagenesScreen({
    Key? key,
    required this.name,
    required this.secuencia,
    required List imagenesFijas,
  }) : super(key: key);

  @override
  _OrdenarImagenesScreenState createState() => _OrdenarImagenesScreenState();
}

class _OrdenarImagenesScreenState extends State<OrdenarImagenesScreen> {
  late List<int?> posiciones;
  List<Puntuacion> puntuaciones = [];
  int puntaje = 0;

  @override
  void initState() {
    super.initState();
    posiciones = List.filled(widget.secuencia.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Cambiar el color de fondo
      appBar: AppBar(
        title: const Text('Ordenar Imágenes'),
        automaticallyImplyLeading: false, // Eliminar la opción de retroceder
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Escribe en que orden ha salido cada uno:',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                Column(
                  children: List.generate(
                    (widget.secuencia.length / 2)
                        .ceil(), // Número de imágenes para la primera columna
                    (index) => SizedBox(
                      width: 100,
                      height:
                          160, // Altura ajustada para acomodar la imagen y el TextField
                      child: Column(
                        children: [
                          Image.asset(
                            widget.secuencia[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                              height:
                                  10), // Espacio entre la imagen y el TextField
                          SizedBox(
                            width: 80,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  posiciones[index] = int.tryParse(value);
                                });
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: '${index + 1}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    (widget.secuencia.length / 2)
                        .floor(), // Número de imágenes para la segunda columna
                    (index) => SizedBox(
                      width: 100,
                      height:
                          160, // Altura ajustada para acomodar la imagen y el TextField
                      child: Column(
                        children: [
                          Image.asset(
                            widget.secuencia[
                                index + (widget.secuencia.length / 2).ceil()],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                              height:
                                  10), // Espacio entre la imagen y el TextField
                          SizedBox(
                            width: 80,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  posiciones[index +
                                      (widget.secuencia.length / 2)
                                          .ceil()] = int.tryParse(value);
                                });
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText:
                                    '${index + (widget.secuencia.length / 2).ceil() + 1}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica de comprobación y puntuación
                int aciertos = 0;
                for (int i = 0; i < widget.secuencia.length; i++) {
                  // Obtener el índice de la imagen correspondiente en la secuencia original
                  int indexOriginal =
                      widget.secuencia.indexOf(widget.secuencia[i]) + 1;
                  if (posiciones[i] == indexOriginal) {
                    aciertos++;
                  }
                }
                setState(() {
                  puntaje = aciertos;
                });

                // SE CREA Y SE GUARDA UNA PUNTUACION
                Puntuacion puntuacionActual =
                    Puntuacion(name: widget.name, puntaje: puntaje);
                guardarPuntuacion(puntuacionActual);

                // Navegar a la pantalla de puntuación
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PuntuacionScreen(
                        name: widget.name, puntaje: puntaje),
                  ),
                );
              },
              child: const Text('Ver Puntuación'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> guardarPuntuacion(Puntuacion puntuacion) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> puntuacionesGuardadas =
        prefs.getStringList('puntuaciones') ?? [];
    // Agregar la nueva puntuación a la lista
    puntuacionesGuardadas.add(json.encode(puntuacion.toJson()));
    await prefs.setStringList('puntuaciones', puntuacionesGuardadas);
  }
}

class PuntuacionScreen extends StatelessWidget {
  final String name;
  final int puntaje;

  const PuntuacionScreen(
      {Key? key, required this.name, required this.puntaje})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Cambiar el color de fondo
      appBar: AppBar(
        title: const Text('Resuelve el problema'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$name, tu puntuación total es: $puntaje',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PuntuacionesGuardadasScreen(),
                    ),
                  );
                },
                child: const Text('Ver otras puntuaciones'))
          ],
        ),
      ),
    );
  }
}
