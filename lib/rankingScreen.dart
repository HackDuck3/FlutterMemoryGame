import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:flutter_application_1/scores.dart';

class PuntuacionesGuardadasScreen extends StatefulWidget {
  const PuntuacionesGuardadasScreen({Key? key}) : super(key: key);

  @override
  _PuntuacionesGuardadasScreenState createState() =>
      _PuntuacionesGuardadasScreenState();
}

class _PuntuacionesGuardadasScreenState
    extends State<PuntuacionesGuardadasScreen> {
  List<Puntuacion> puntuacionesGuardadas = [];
  late SupabaseClient client;

  @override
  void initState() {
    super.initState();
    client = SupabaseClient('https://ncbqxdgcvkdgrdbfdmxw.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5jYnF4ZGdjdmtkZ3JkYmZkbXh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYzMTc1NDEsImV4cCI6MjAxMTg5MzU0MX0.zWGkhRrXm7XKRnJeo6eU-uLm4DCNy4VeTe38W6MYx30');
    _cargarPuntuacionesGuardadas();
  }

  Future<void> _cargarPuntuacionesGuardadas() async {
    final response = await client
        .from('users')
        .select()
        .order('user_point', ascending: false)
        .limit(10);

    final List<dynamic> data = response;
    List<Puntuacion> puntuaciones = data
        .map((item) => Puntuacion(
              name: item['user_name'] as String,
              puntaje: item['user_point'] as int,
            ))
        .toList();

    setState(() {
      puntuacionesGuardadas = puntuaciones;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 10 de las mejores puntuaciones'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos celdas por fila
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: puntuacionesGuardadas.length,
        itemBuilder: (context, index) {
          final puntuacion = puntuacionesGuardadas[index];
          final name = puntuacion.name;
          final puntaje = puntuacion.puntaje;

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Puntuación: $puntaje',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
